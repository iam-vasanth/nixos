{ ... }:
{
  imports = [
    # Hjem
    ./hjem/hjem.nix
    ./hjem/theming.nix

    # Programs
    ./programs/noctalia.nix

    # WM
    ./wm/common.nix
    ./wm/niri/niri.nix
  ];
}
