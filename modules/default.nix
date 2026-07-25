{ ... }:
{
  imports = [
    # Hjem
    ./hjem/hjem.nix
    ./hjem/etc.nix

    # Packages
    ./packages/system.nix
    ./packages/flatpak.nix

    # Programs
    ./programs/noctalia.nix
    ./programs/mpv.nix
    # ./programs/spicetify.nix # Too broke for a premium

    # WM
    ./wm/common.nix
    ./wm/niri/niri.nix
  ];
}
