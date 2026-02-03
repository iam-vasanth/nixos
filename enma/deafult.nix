{ host, user, pkgs, lib, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix

    ];

    # Power profile
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

  system.stateVersion = "25.11"; # Do not touch this
}
