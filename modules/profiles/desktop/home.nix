{ inputs, ... }:

{
  imports = [
    ./modules/home-common/git.nix
    ./modules/home-common/ssh.nix
    ./modules/home-common/fish.nix
    ./modules/home-common/kitty.nix
    ./modules/home-common/starship.nix
    ./modules/home-common/zed-editor.nix
    ./modules/profiles/desktop/home/fastfetch.nix
    ./modules/profiles/desktop/home/mimeapps.nix
    ./modules/profiles/desktop/home/pkgs.nix
    ./modules/profiles/desktop/home/shell.nix
    ./modules/profiles/desktop/home/symlinks.nix

    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.sops-nix.homeManagerModules.sops
  ];

  # Enables bluetooth audio controls
  services.mpris-proxy.enable = true;

}
