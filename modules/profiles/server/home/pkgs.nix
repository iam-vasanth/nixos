{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    pkgs.gedit
    # Fish dependencies
    pkgs.fzf # fish : fzf-fish and forgit plugins
    pkgs.grc # fish : grc plugin
    pkgs.nix-your-shell  # fish optional : Nix develop ~/home/configs/fish.nix line:44
    pkgs.nixd # Zed-Editor : language server
    # sops-nix
    pkgs.sops
    pkgs.age
    pkgs.ssh-to-age
  ];

  services.flatpak = {
    enable = true;
    packages = [

      # { appId = "flathub:com.ml4w.dotfilesinstaller"; origin = "flathub" } # To add a flatpak

    ];
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
