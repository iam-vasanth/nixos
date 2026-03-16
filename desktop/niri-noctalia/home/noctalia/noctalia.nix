{ ... }:

{
  imports = [

    # General, User Interface, Notifications(Sounds), Screen Recorder
    ./noctalia/general.nix

    # Bar and Dock
    ./noctalia/bar.nix

    # Matugen templates, Wallpaper and Color schemes
    ./noctalia/colors.nix

    # Applauncher, Control center and Desktop widgets
    ./noctalia/components.nix

    # Audio, Brightness, Calender, Location and Network
    ./noctalia/services.nix

    # Session menu, Power options and System monitor
    ./noctalia/system.nix

    # Hooks, Night light and OSD
    ./noctalia/misc.nix

    # Custom matugen templates
    ./noctalia/userTemplates.nix

  ];

  # Enables bluetooth audio controls
  services.mpris-proxy.enable = true;

  programs.noctalia-shell.enable = true;
  # programs.noctalia-shell.systemd.enable = true;
}
