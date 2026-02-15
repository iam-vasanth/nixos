{ host, user, pkgs, lib, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./common/boot.nix
      ./common/user.nix
      ./common/pkgs.nix
      ./common/misc.nix
    ];

    # Special boot kernal params
    boot.kernelParams = [
      "i915.force_probe=46a6"
    ];

    # Power profile
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    # Enables Niri window manager
    programs.niri.enable = true;

    # Auto GDM login with keyring unlock with LUKS
    services.displayManager = {
      autoLogin = {
        enable = true;
        user = "${user}";
      };
      gdm = {
        enable = true;
        wayland = true;
        autoSuspend = false;
      };
    };
    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = with pkgs; [
      pkgs.xwayland-satellite
    ];

  system.stateVersion = "25.11"; # Do not touch this
}
