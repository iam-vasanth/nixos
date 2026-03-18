{ inputs, ... }:

{
  imports = [
    ../../home-common/git.nix
    ../../home-common/ssh.nix
    ../../home-common/fish.nix
    ../../home-common/kitty.nix
    ../../home-common/starship.nix
    ../../home-common/zed-editor.nix
    ../../home-common/niri/default.nix
    ./home/fastfetch.nix
    ./home/mimeapps.nix
    ./home/pkgs.nix
    ./home/shell.nix
    ./home/symlinks.nix
  ];

  # Enables bluetooth audio controls
  services.mpris-proxy.enable = true;

  home.stateVersion = "25.11";

}
