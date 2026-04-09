{
  inputs,
  hostname,
  user,
  pkgs,
  ...
}: {
  imports = [
    # Import nixos modules if needed ...
  ];

  ###########################################################################
  # Hostname
  ###########################################################################

  networking.hostName = "${hostname}";

  ###########################################################################
  # Enables Niri and GDM
  ###########################################################################

  # Niri with Sodiboo's niri cache
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  services.desktopManager.gnome.enable = true;

  # GDM auto login
  services.displayManager = {
    # autoLogin = {
    #   enable = true;
    #   user = "${user}";
    # };
    gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };
  };

  # Uncomment if using LUKS with GDM autologin for auto keyring unlock.
  # services.gnome.gnome-keyring.enable = true;

  # Disabled default polkit to use DMS's built-in polkit
  systemd.user.services.niri-flake-polkit.enable = false;

  ###########################################################################
  # Power profile
  ###########################################################################

  services.power-profiles-daemon.enable = true;

  ###########################################################################
  # XDG Portals
  ###########################################################################

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk # fallback for file pickers, etc.
      xdg-desktop-portal-gnome # required for screencast on Niri
    ];

    config = {
      common = {
        default = ["gtk"]; # GTK as general fallback

        # Force ScreenCast to use the GNOME backend.
        "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
      };
    };
  };

  ###########################################################################
  # USB handling
  ###########################################################################

  services.udisks2.enable = true;

  ###########################################################################
  # Host specific packages
  ###########################################################################

  environment.systemPackages = [
    pkgs.kitty
    pkgs.nautilus
    pkgs.wev
    pkgs.xwayland-satellite
    pkgs.firefox
  ];

  ###########################################################################
  # Home Manager
  ###########################################################################

  home-manager.users.${user} = import ./home.nix;
}
