{ config, lib, user, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "dev.zed.Zed.desktop";
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

  home.file = {

    # Created a folder Projects in home directory
    "Projects/.keep".text = "";

    # Adds bookmarks to folders to nautilus bookmarks
    ".config/gtk-3.0/bookmarks".text = ''
      file://${config.home.homeDirectory}/Downloads
      file://${config.home.homeDirectory}/Documents
      file://${config.home.homeDirectory}/Projects
      file://${config.home.homeDirectory}/Pictures
      file://${config.home.homeDirectory}/Videos
      file://${config.home.homeDirectory}/Music
    '';
  };

  home.activation.zenChrome = lib.hm.dag.entryAfter ["writeBoundary"] ''
    for PROFILE_DIR in \
        "$(find ~/.zen -maxdepth 1 -type d -name "*.Default Profile" 2>/dev/null | head -n 1)" \
        "$(find "$HOME/.config/zen" -maxdepth 1 -type d -name "*Default (release)" 2>/dev/null | head -n 1)" \
        "$(find "$HOME/.var/app/app.zen_browser.zen/.zen" -maxdepth 1 -type d -name "*Default (release)" 2>/dev/null | head -n 1)"
    do
        [ -z "$PROFILE_DIR" ] && continue
        mkdir -p "$PROFILE_DIR/chrome"
        ln -sf "$HOME/.config/DankMaterialShell/zen.css" "$PROFILE_DIR/chrome/userChrome.css"
    done
  '';

 }
