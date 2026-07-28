{
  config,
  user,
  ...
}: {
  ###########################################################################
  # Directories
  ###########################################################################

  hjf = {
    #########################################################################
    # Create Projects directory
    #########################################################################

    "Downloads/.keep".text = "";
    "Projects/.keep".text = "";
    "Documents/.keep".text = "";
    "Music/.keep".text = "";
    "Pictures/.keep".text = "";
    "Videos/.keep".text = "";

    ".config/user-dirs.dirs".text = ''
      XDG_DOWNLOAD_DIR="${config.users.users.${user}.home}/Downloads"
      XDG_DOCUMENTS_DIR="${config.users.users.${user}.home}/Documents"
      XDG_MUSIC_DIR="${config.users.users.${user}.home}/Music"
      XDG_PICTURES_DIR="${config.users.users.${user}.home}/Pictures"
      XDG_VIDEOS_DIR="${config.users.users.${user}.home}/Videos"
    '';

    ".config/user-dirs.locale".text = "en_US";

    #########################################################################
    # GTK bookmarks
    #########################################################################

    ".config/gtk-3.0/bookmarks".text = ''
      file://${config.users.users.${user}.home}/Downloads
      file://${config.users.users.${user}.home}/Documents
      file://${config.users.users.${user}.home}/Projects
      file://${config.users.users.${user}.home}/Pictures
      file://${config.users.users.${user}.home}/Videos
      file://${config.users.users.${user}.home}/Music
    '';

    #########################################################################
    # Symlinks
    #########################################################################

    "Pictures/Wallpapers".source = ./../../assets/Wallpapers;

    # ".ssh/zoro_key.pub".source =
    #   ../../../../.secrets/public_keys/zoro_key.pub;
  };
}
