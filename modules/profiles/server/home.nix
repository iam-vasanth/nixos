{ ... }:

{
  imports = [
    ./modules/home-common/git.nix
    ./modules/home-common/ssh.nix
    ./modules/home-common/fish.nix
    ./modules/home-common/kitty.nix
    ./modules/home-common/starship.nix
    ./modules/profiles/desktop/home/pkgs.nix
    ./modules/profiles/desktop/home/shell.nix
  ];
}
