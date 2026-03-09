{
  pkgs,
  lib,
  user,
  host1,
  ...
}: {
  # ── Identity ───────────────────────────────────────────────────────────
  networking.hostName = "server";

  # ── Users ──────────────────────────────────────────────────────────────
  users.users = {
    you = {
      # ← change "you" to your username
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = ["wheel" "podman"];
      openssh.authorizedKeys.keys = [
        # "ssh-ed25519 AAAA... you@thinkpad"
      ];
    };
  };

  # ── Home Manager (minimal, headless) ──────────────────────────────────
  home-manager.users.you = {pkgs, ...}: {
    home.stateVersion = "24.11";
    programs.zsh.enable = true;
    programs.git.enable = true;
  };

  # ── Locale ─────────────────────────────────────────────────────────────
  time.timeZone = "UTC";
}
