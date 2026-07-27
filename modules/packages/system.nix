{ pkgs, unstable,... }:
{

  environment.systemPackages = [

    ###########################################################################
    # System
    ###########################################################################

    pkgs.gitFull
    pkgs.wev
    pkgs.kitty
    pkgs.firefox
    pkgs.ffmpeg

    ###########################################################################
    # Normal
    ###########################################################################

    unstable.spotatui
    unstable.spotube
    pkgs.yt-dlp
    pkgs.nautilus
    pkgs.loupe
    pkgs.zed-editor
    pkgs.neovim
    pkgs.starship
    pkgs.fastfetch
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

    # Fish dependencies
    pkgs.fzf
    pkgs.grc
    pkgs.nix-your-shell


    # Zed-Editor : nix language server
    pkgs.nixd

  ];

}
