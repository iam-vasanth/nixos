{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = [
    ###########################################################################
    # Core
    ###########################################################################

    pkgs.wev
    pkgs.wlr-randr
    pkgs.ffmpeg
    pkgs.nautilus

    ###########################################################################
    # Normal
    ###########################################################################

    pkgs.yt-dlp
    pkgs.loupe
    pkgs.neovim
    pkgs.lazygit
    pkgs.lazydocker
    pkgs.distrobox
    pkgs.rstudio
    pkgs.localsend
    pkgs._7zz-rar
    pkgs.btop
    pkgs.mpv
    pkgs.android-tools
    pkgs.obsidian

    ###########################################################################
    # Themes and Fonts
    ###########################################################################

    # Themes
    pkgs.bibata-cursors
    pkgs.papirus-icon-theme
    pkgs.adwaita-icon-theme
    pkgs.hicolor-icon-theme
    pkgs.shared-mime-info
    pkgs.kdePackages.breeze
    pkgs.kdePackages.breeze.qt5
    pkgs.kdePackages.breeze-icons

    # Fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    pkgs.fira-code-symbols
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.hack
    pkgs.inter-nerdfont
    pkgs.atkinson-hyperlegible-next

    ###########################################################################
    # Others
    ###########################################################################

    # Zed-Editor : nix language server
    pkgs.nixd
  ];
}
