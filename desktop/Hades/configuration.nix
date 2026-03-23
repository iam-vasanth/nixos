{
  pkgs,
  lib,
  user,
  host1,
  ...
}: {
  # ── Identity ───────────────────────────────────────────────────────────
  networking.hostName = "server";

  # ── Home Manager (minimal, headless) ──────────────────────────────────
  home-manager.users.you = {pkgs, ...}: {
    home.stateVersion = "24.11";
    programs.zsh.enable = true;
    programs.git.enable = true;
  };

  # ── Locale ─────────────────────────────────────────────────────────────
  time.timeZone = "UTC";
}
