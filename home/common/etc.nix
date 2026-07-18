{
  config,
  lib,
  ...
}: {
  ###########################################################################
  # Default apps with Session vars
  ###########################################################################

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  ###########################################################################
  # XDG folders
  ###########################################################################

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
    music = "${config.home.homeDirectory}/Music";
    publicShare = null;
    templates = null;
    desktop = null;
  };

  ###########################################################################
  # Extra home file config
  ###########################################################################

  home.file = {
    # Creats a folder Projects in home directory
    "Projects/.keep".text = "";

    # Adds bookmarks to nautilus
    ".config/gtk-3.0/bookmarks".text = ''
      file://${config.home.homeDirectory}/Downloads
      file://${config.home.homeDirectory}/Documents
      file://${config.home.homeDirectory}/Projects
      file://${config.home.homeDirectory}/Pictures
      file://${config.home.homeDirectory}/Videos
      file://${config.home.homeDirectory}/Music
    '';
  };

  ###########################################################################
  # Symlinks
  ###########################################################################

  home.file."Pictures/Wallpapers".source = ../../assets/Wallpapers;
  home.file.".config/fastfetch/fastfetch.txt".source = ../../assets/fastfetch.txt;
  # home.file.".ssh/zoro_key.pub".source = ../../../../.secrets/public_keys/zoro_key.pub;

  ###########################################################################
  # Virt-manager connection
  ###########################################################################

  dconf = {
    enable = true;
    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
