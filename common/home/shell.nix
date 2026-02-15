{ config, user, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "zed-editor";
  };

  # Sets up XDG folders
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

  # Adds bookmarks to folders to nautilus bookmarks
  home.file = {
    ".config/gtk-3.0/bookmarks".text = ''
      file://${config.home.homeDirectory}/Downloads
      file://${config.home.homeDirectory}/Documents
      file://${config.home.homeDirectory}/Projects
      file://${config.home.homeDirectory}/Pictures
      file://${config.home.homeDirectory}/Videos
      file://${config.home.homeDirectory}/Music
    '';
  };
}
