{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    pkgs.gedit
    # sops-nix
    pkgs.sops
    pkgs.age
    pkgs.ssh-to-age
  ];
}
