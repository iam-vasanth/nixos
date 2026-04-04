{inputs, ...}: {
  imports = [
    # Common home modules - lives in ./modules/home-common/
    ../../home-common/sops.nix
    ../../home-common/git.nix
    ../../home-common/ssh.nix
    ../../home-common/fish.nix
    ../../home-common/kitty.nix
    ../../home-common/starship.nix
    ../../home-common/zed-editor.nix
    ../../home-common/niri.nix

    # Desktop specific home modules
    ./home/fastfetch.nix
    ./home/mimeapps.nix
    ./home/pkgs.nix
    ./home/shell.nix
    ./home/symlinks.nix
  ];

  ###########################################################################
  # Enables bluetooth audio controls
  ###########################################################################

  services.mpris-proxy.enable = true;

  ###########################################################################
  # State version - Do not touch this
  ###########################################################################

  home.stateVersion = "25.11";
}
