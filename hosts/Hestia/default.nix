{ paths,... }:
{

  imports = [
    /etc/nixos/hardware-configuration.nix
    ./vm-guest.nix
  ];
  wm.niri.enable = true;
  wm.common.enable = true;
  programs.noctalia.enable = true;
}
