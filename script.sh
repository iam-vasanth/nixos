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
# Pick host
# ---------------------------------------------------------------------------
echo "Select host to install:"
select HOSTNAME in "Ares" "Athena" "Hestia"; do
  [[ -n "${HOSTNAME:-}" ]] && break
done

case "$HOSTNAME" in
  Ares|Athena) HOSTDIR="thinkpad-x1" ;;
  Hestia)      HOSTDIR="vm" ;;
  *) echo "Unknown host"; exit 1 ;;
esac

# ---------------------------------------------------------------------------
# Clone the flake
# ---------------------------------------------------------------------------
rm -rf "$WORKDIR"
eval "$GIT_CMD clone \"$FLAKE_REPO\" \"$WORKDIR\""
cd "$WORKDIR"

# ---------------------------------------------------------------------------
# Confirm disk wipe
# ---------------------------------------------------------------------------
echo
echo "!! This will WIPE the disk defined in hosts/$HOSTDIR/disko.nix !!"
grep -m1 device "hosts/$HOSTDIR/disko.nix"
echo
read -rp "Type 'yes' to continue: " CONFIRM
[[ "$CONFIRM" == "yes" ]] || { echo "Aborted."; exit 1; }

# ---------------------------------------------------------------------------
# Partition + format + mount via disko
# ---------------------------------------------------------------------------
nix --extra-experimental-features "nix-command flakes" run \
  "github:nix-community/disko/${DISKO_REV}" -- \
  --mode disko "hosts/$HOSTDIR/disko.nix"

# ---------------------------------------------------------------------------
# Generate hardware-configuration.nix (disko already handled filesystems)
# ---------------------------------------------------------------------------
nixos-generate-config --no-filesystems --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix "hosts/$HOSTDIR/hardware-configuration.nix"
echo "Wrote hosts/$HOSTDIR/hardware-configuration.nix"

# ---------------------------------------------------------------------------
# Copy the flake onto the target and install
# ---------------------------------------------------------------------------
mkdir -p /mnt/etc/nixos
rm -rf /mnt/etc/nixos/* 2>/dev/null || true
cp -r "$WORKDIR"/. /mnt/etc/nixos/

nixos-install --flake "/mnt/etc/nixos#$HOSTNAME" --no-root-passwd

# ---------------------------------------------------------------------------
# Set user password inside the new system
# ---------------------------------------------------------------------------
echo
echo "Set a login password for your user now:"
nixos-enter --root /mnt -c "passwd zoro"

echo
echo "== Install complete =="
echo "Reboot into the new system with: reboot"
