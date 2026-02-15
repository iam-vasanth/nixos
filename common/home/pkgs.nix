{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    pkgs.kitty
    pkgs.starship
    pkgs.fastfetch
    pkgs.lazygit
    pkgs.lazydocker
    pkgs.distrobox
    pkgs.teams-for-linux
    pkgs.rstudio
    pkgs.loupe
    pkgs.localsend
    pkgs.bitwarden-desktop
    pkgs.amberol
    pkgs.vesktop
    pkgs.unrar
    # Fish dependencies
    pkgs.fzf # fish : fzf-fish and forgit plugins
    pkgs.grc # fish : grc plugin
    pkgs.nix-your-shell  # fish optional : check fish.nix
    pkgs.nixd # Zed-Editor : language server
    # sops-nix
    pkgs.sops
    pkgs.age
    pkgs.ssh-to-age
  ];

  services.flatpak = {
    enable = true;
    packages = [
      { appId = "app.zen_browser.zen"; origin = "flathub"; }
      { appId = "com.spotify.Client"; origin = "flathub"; }
      { appId = "de.haeckerfelix.Fragments"; origin = "flathub"; }
      { appId = "com.github.tchx84.Flatseal"; origin = "flathub"; }
      { appId = "org.videolan.VLC"; origin = "flathub"; }
      { appId = "io.gitlab.adhami3310.Impression"; origin = "flathub"; }
      { appId = "com.ranfdev.DistroShelf"; origin = "flathub"; }
      { appId = "io.github.flattool.Warehouse"; origin = "flathub"; }
      { appId = "com.stremio.Stremio"; origin = "flathub"; }
      { appId = "com.usebottles.bottles"; origin = "flathub"; }
      { appId = "org.signal.Signal"; origin = "flathub"; }
      # { appId = "flathub:com.ml4w.dotfilesinstaller"; origin = "flathub" } # For dotfiles management
    ];
    # Flatpak autoupdate
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
