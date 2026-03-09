{ user, noctalia, nix-flatpak, sops-nix, ... }:

{
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.11"; # Do not touch.

  imports = [
    ./home/noctalia.nix
    ./home/symlinks.nix
    ./home/pkgs.nix
    ./home/shell.nix
    # ./home/nixcord.nix
    ./home/git.nix
    ./home/ssh.nix
    ./home/configs.nix
    noctalia.homeModules.default
    nix-flatpak.homeManagerModules.nix-flatpak
    sops-nix.homeManagerModules.sops
  ];

  programs.home-manager.enable = true;
}
