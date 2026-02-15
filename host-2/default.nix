{ host, user, pkgs, pkgs-unstable, ... }:

{
  imports = [
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

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enables the GNOME desktop environment
  services.desktopManager.gnome.enable = true;

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

  # Power profile and management
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Battery charge thresholds
      START_CHARGE_THRESH_BAT0 = 75; # Start charging when below 75%
      STOP_CHARGE_THRESH_BAT0 = 80; # Stop charging when above 80%

      # Other useful defaults (TLP enables many automatically)
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  system.stateVersion = "25.11"; # Do not touch this
}
