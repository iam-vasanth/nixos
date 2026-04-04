{
  hostname,
  user,
  pkgs,
  unstable,
  ...
}: {
  ###########################################################################
  # Identity
  ###########################################################################

  networking.hostName = "${host1}";

  ###########################################################################
  # Enables Niri and GDM
  ###########################################################################

  # Niri with Sodiboo's niri cache
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # GDM auto login
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

  # ncomment if using LUKS with GDM autologin for auto keyring unlocks but this will render the noctalia fprintd un-usable
  services.gnome.gnome-keyring.enable = true;

  ###########################################################################
  # Power profile
  ###########################################################################

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  ###########################################################################
  # Host specific packages
  ###########################################################################

  environment.systemPackages = [
    pkgs.kitty
    pkgs.nautilus
    pkgs.xwayland-satellite
  ];

  ###########################################################################
  # Home Manager
  ###########################################################################

  home-manager.users.${user} = import ./desktop/niri-noctalia/home.nix;
}
