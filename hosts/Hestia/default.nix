{ paths,... }:
{

  imports = [
    ./vm-guest.nix
  ];
  wm.niri.enable = true;
  wm.common.enable = true;
  programs.noctalia.enable = true;
}
