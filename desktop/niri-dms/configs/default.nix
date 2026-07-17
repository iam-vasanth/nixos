{
  inputs,
  hostname,
  user,
  pkgs,
  ...
}: {
  imports = [
    inputs.dms.nixosModules.dank-material-shell
    inputs.dms.nixosModules.greeter
  ];

  ###########################################################################
  # Enables DMS
  ###########################################################################

  programs.dank-material-shell = {
    enable = true;
    enableDynamicTheming = true;
    niri.includes.enable = false;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/${user}";
    };
  }

  ###########################################################################
  # Enables Niri and GDM
  ###########################################################################

  # programs.niri.enable = true;

  # GDM auto login
  # services.displayManager = {
  #   autoLogin = {
  #     enable = true;
  #     user = "${user}";
  #   };
  #   gdm = {
  #     enable = true;
  #     wayland = true;
  #     autoSuspend = false;
  #   };
  # };

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

  # xdg.portal = {
  #   enable = true;

  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk # fallback for file pickers, etc.
  #     xdg-desktop-portal-gnome # required for screencast on Niri
  #   ];

  #   config = {
  #     common = {
  #       default = ["gtk"]; # GTK as general fallback

  #       # Force ScreenCast to use the GNOME backend.
  #       "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
  #     };
  #   };
  # };

  ###########################################################################
  # USB handling
  ###########################################################################

  services.udisks2.enable = true;
  services.udiskie.enable = true;
}
