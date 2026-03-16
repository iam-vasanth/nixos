{ inputs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri

    ./modules/home-common/niri/input.nix
    ./modules/home-common/niri/output.nix
    ./modules/home-common/niri/window.nix
    ./modules/home-common/niri/ui.nix
    ./modules/home-common/niri/keybinds.nix
    ./modules/home-common/niri/env.nix
    ./modules/home-common/niri/extra.nix
  ];
}
