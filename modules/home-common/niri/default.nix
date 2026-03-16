{ inputs, ... }:

{
  imports = [
    # inputs.niri-flake.homeModules.niri

    ./input.nix
    ./output.nix
    ./window.nix
    ./ui.nix
    ./keybinds.nix
    ./env.nix
    ./extra.nix
  ];
}
