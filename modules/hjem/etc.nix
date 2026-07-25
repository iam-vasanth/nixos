{
  config,
  lib,
  ...
}: {
  ###########################################################################
  # Directories
  ###########################################################################

  files = {
    #########################################################################
    # Create Projects directory
    #########################################################################

    "Projects/.keep".text = "";

    #########################################################################
    # GTK bookmarks
    #########################################################################

    ".config/gtk-3.0/bookmarks".text = ''
      file://${config.home.directory}/Downloads
      file://${config.home.directory}/Documents
      file://${config.home.directory}/Projects
      file://${config.home.directory}/Pictures
      file://${config.home.directory}/Videos
      file://${config.home.directory}/Music
    '';

    #########################################################################
    # Symlinks
    #########################################################################

    "Pictures/Wallpapers".source = ../../assets/Wallpapers;

    ".config/fastfetch/fastfetch.txt".source =
      ../../assets/fastfetch.txt;

    # ".ssh/zoro_key.pub".source =
    #   ../../../../.secrets/public_keys/zoro_key.pub;
  };
}
