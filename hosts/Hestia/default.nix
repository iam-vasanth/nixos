{...}: {
  imports = [
    ./vm-guest.nix
  ];

  ###########################################################################
  # Window Manager
  ###########################################################################

  wm.niri.enable = true;
  wm.common.enable = true;
  programs.noctalia.enable = true;
}
