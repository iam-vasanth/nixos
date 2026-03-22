{ ... }:

{
  imports = [
    ../../home-common/git.nix
    ../../home-common/ssh.nix
    ./home/symlinks.nix
  ];

  home.stateVersion = "25.11";
}
