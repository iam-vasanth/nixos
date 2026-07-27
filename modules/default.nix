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
    ./programs/fastfetch.nix
    ./programs/git.nix
    ./programs/mpv.nix
    ./programs/noctalia.nix
    ./programs/playerctld.nix
    ./programs/udiskie.nix
    # ./programs/spicetify.nix # Too broke for a premium

    # WM
    ./wm/common.nix
    ./wm/niri/niri.nix
  ];
}
