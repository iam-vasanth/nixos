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

    "Projects/.keep".text = "";

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
