{ ... }:

{
  imports = [
    ../../home-common/sops.nix
    ../../home-common/git.nix
    ../../home-common/ssh.nix
    ./home/pkgs.nix
    ./home/symlinks.nix
  ];

  home.stateVersion = "25.11";
}
