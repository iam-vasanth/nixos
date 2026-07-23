{
  pkgs,
  unstable,
  ...
}: {
  ###########################################################################
  # Font config generation ( User level )
  ###########################################################################

  fonts.fontconfig.enable = true;

  ###########################################################################
  # User specific packages
  ###########################################################################

  home.packages = [
    pkgs.zed-editor
    pkgs.neovim
    pkgs.kitty
    pkgs.starship
    pkgs.fastfetch
    pkgs.lazygit
    pkgs.lazydocker
    pkgs.distrobox
    pkgs.rstudio
    pkgs.loupe
    pkgs.localsend
    pkgs._7zz-rar
    pkgs.btop
    pkgs.mpv
    pkgs.android-tools
    pkgs.obsidian
    # ... add more packages here

    # Fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    pkgs.fira-code-symbols
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.hack
    pkgs.inter-nerdfont
    # ... add more fonts here

    # Fish dependencies
    pkgs.fzf
    pkgs.grc
    pkgs.nix-your-shell

    # Zed-Editor : nix language server
    pkgs.nixd
  ];

  ###########################################################################
  # Flatpaks
  ###########################################################################

  services.flatpak = {
    enable = true;

    packages = [
      {
        appId = "app.zen_browser.zen";
        origin = "flathub";
      }
      {
        appId = "com.spotify.Client";
        origin = "flathub";
      }
      {
        appId = "de.haeckerfelix.Fragments";
        origin = "flathub";
      }
      {
        appId = "com.github.tchx84.Flatseal";
        origin = "flathub";
      }
      {
        appId = "io.gitlab.adhami3310.Impression";
        origin = "flathub";
      }
      {
        appId = "com.ranfdev.DistroShelf";
        origin = "flathub";
      }
      {
        appId = "io.github.flattool.Warehouse";
        origin = "flathub";
      }
      {
        appId = "com.usebottles.bottles";
        origin = "flathub";
      }
      {
        appId = "com.rustdesk.RustDesk";
        origin = "flathub";
      }
      {
        appId = "io.github.anil_e.Codd";
        origin = "flathub";
      }
      {
        appId = "com.github.marhkb.Pods";
        origin = "flathub";
      }
      {
        appId = "com.protonvpn.www";
        origin = "flathub";
      }
      {
        appId = "com.github.IsmaelMartinez.teams_for_linux";
        origin = "flathub";
      }
      {
        appId = "dev.skynomads.Seabird";
        origin = "flathub";
      }
      {
        appId = "org.telegram.desktop";
        origin = "flathub";
      }
      {
        appId = "dev.vencord.Vesktop";
        origin = "flathub";
      }
    ];

    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
