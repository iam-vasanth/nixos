#!/usr/bin/env bash

set -euo pipefail

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------
FLAKE_REPO="https://github.com/iam-vasanth/nixos.git"
WORKDIR="/tmp/nixos"
DISKO_REV="ff8702b4de27f72b4c78573dfb89ec74e36abdf1"

# ---------------------------------------------------------------------------
# Must be root
# ---------------------------------------------------------------------------
if [[ "$EUID" -ne 0 ]]; then
  echo "Re-run as root (e.g. 'sudo -i' first on the live ISO)."
  exit 1
fi

echo "== NixOS flake bootstrap installer =="

# ---------------------------------------------------------------------------
# Network check
# ---------------------------------------------------------------------------
if ! ping -c1 -W2 8.8.8.8 &>/dev/null; then
  echo "No network detected."
  echo "Launching nmtui — connect to Wi-Fi/Ethernet, then quit nmtui to continue."
  command -v nmtui &>/dev/null && nmtui || {
    echo "nmtui not found; connect manually then re-run this script."
    exit 1
  }
fi

# ---------------------------------------------------------------------------
# Ensure git is available
# ---------------------------------------------------------------------------
if ! command -v git &>/dev/null; then
  echo "git not found, fetching it via nix shell..."
  GIT_CMD="nix --extra-experimental-features 'nix-command flakes' shell nixpkgs#git -c git"
else
  GIT_CMD="git"
fi

# ---------------------------------------------------------------------------
# Clone the flake
# ---------------------------------------------------------------------------
rm -rf "$WORKDIR"
eval "$GIT_CMD clone \"$FLAKE_REPO\" \"$WORKDIR\""
cd "$WORKDIR"

# ---------------------------------------------------------------------------
# Pick host
# ---------------------------------------------------------------------------
echo "Select host to install:"
select HOSTNAME in "Athena" "Ares" "Hestia"; do
  [[ -n "${HOSTNAME:-}" ]] && break
done

# ---------------------------------------------------------------------------
# User and Root password
# ---------------------------------------------------------------------------
echo
echo "Root account:"
select ROOT_CHOICE in \
    "Lock root (recommended — use sudo via 'zoro')" \
    "Also set a root password"; do
    [[ -n "${ROOT_CHOICE:-}" ]] && break
done

ROOT_PASSWD=""

if [[ "$ROOT_CHOICE" == "Also set a root password" ]]; then
    while true; do
        read -rsp "New password for root: " ROOT_PASSWD; echo
        read -rsp "Confirm root password: " ROOT_PASSWD_CONFIRM; echo

        [[ "$ROOT_PASSWD" == "$ROOT_PASSWD_CONFIRM" && -n "$ROOT_PASSWD" ]] && break
        echo "Passwords didn't match (or were empty) — try again."
    done
    unset ROOT_PASSWD_CONFIRM
fi

echo

while true; do
    read -rsp "Password for zoro: " USER_PASSWD; echo
    read -rsp "Confirm zoro password: " USER_PASSWD_CONFIRM; echo

    [[ "$USER_PASSWD" == "$USER_PASSWD_CONFIRM" && -n "$USER_PASSWD" ]] && break
    echo "Passwords didn't match (or were empty) — try again."
done
unset USER_PASSWD_CONFIRM

# ---------------------------------------------------------------------------
# Confirm disk wipe
# ---------------------------------------------------------------------------
echo
echo "!! This will WIPE the disk defined in hosts/$HOSTNAME/disko.nix !!"
grep -m1 '^[[:space:]]*device =' hosts/$HOSTNAME/disko.nix
echo
read -rp "Type 'yes' to continue: " CONFIRM
[[ "$CONFIRM" == "yes" ]] || { echo "Aborted."; exit 1; }

# ---------------------------------------------------------------------------
# Partition + format + mount via disko
# ---------------------------------------------------------------------------
nix --extra-experimental-features "nix-command flakes pipe-operators" run \
  "github:nix-community/disko/${DISKO_REV}" -- \
  --mode disko "hosts/$HOSTNAME/disko.nix"

# ----------------------f-----------------------------------------------------
# Copy the flake onto the target and install
# ---------------------------------------------------------------------------
mkdir -p /mnt/etc/nixos
rm -rf /mnt/etc/nixos/* 2>/dev/null || true
cp -r "$WORKDIR"/. /mnt/etc/nixos/

nixos-install --flake "/mnt/etc/nixos#$HOSTNAME" --no-root-passwd

# ---------------------------------------------------------------------------
# Set passwords inside the new system
# ---------------------------------------------------------------------------
echo

printf '%s:%s\n' "zoro" "$USER_PASSWD" | nixos-enter --root /mnt -c "chpasswd"
unset USER_PASSWD

if [[ -n "$ROOT_PASSWD" ]]; then
    printf '%s:%s\n' "root" "$ROOT_PASSWD" | nixos-enter --root /mnt -c "chpasswd"
    unset ROOT_PASSWD
fi

echo
echo "== Install complete =="
echo "Rebooting in 10 seconds..."
sleep 10
reboot
