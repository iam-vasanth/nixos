{ pkgs, unstable, ... }:

{

  fonts.fontconfig.enable = true;

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
    pkgs.signal-desktop
    pkgs.vesktop
    pkgs.blanket
    pkgs._7zz-rar
    pkgs.btop
    pkgs.mpv
    pkgs.termius

    # Fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    pkgs.fira-code-symbols
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.hack
    pkgs.inter-nerdfont

    # Fish dependencies
    pkgs.fzf # fish : fzf-fish and forgit plugins
    pkgs.grc # fish : grc plugin
    pkgs.nix-your-shell  # fish  : Nix develop

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
      { appId = "com.rustdesk.RustDesk"; origin = "flathub"; }
      { appId = "net.codelogistics.webapps"; origin = "flathub"; }
      { appId = "md.obsidian.Obsidian"; origin = "flathub"; }

      # { appId = "flathub:com.ml4w.dotfilesinstaller"; origin = "flathub" } # To add a flatpak
    ];
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
