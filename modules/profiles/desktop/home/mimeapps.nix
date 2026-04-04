{...}: {
  ###########################################################################
  # Mimeapps list ( Default apps list )
  ###########################################################################

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Images – Loupe
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/gif" = ["org.gnome.Loupe.desktop"];
      "image/webp" = ["org.gnome.Loupe.desktop"];
      "image/bmp" = ["org.gnome.Loupe.desktop"];
      "image/svg+xml" = ["org.gnome.Loupe.desktop"];
      "image/tiff" = ["org.gnome.Loupe.desktop"];
      "image/heic" = ["org.gnome.Loupe.desktop"];
      "image/heif" = ["org.gnome.Loupe.desktop"];

      # Video files – MPV
      "video/mp4" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "video/quicktime" = ["mpv.desktop"];
      "video/x-msvideo" = ["mpv.desktop"];
      "video/mpeg" = ["mpv.desktop"];
      "video/ogg" = ["mpv.desktop"];
      "video/x-flv" = ["mpv.desktop"];
      "video/x-ms-wmv" = ["mpv.desktop"];

      # Audio files – MPV
      "audio/mp3" = ["mpv.desktop"];
      "audio/mpeg" = ["mpv.desktop"];
      "audio/ogg" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];
      "audio/wav" = ["mpv.desktop"];
      "audio/x-wav" = ["mpv.desktop"];
      "audio/aac" = ["mpv.desktop"];

      # Code/data formats – Zed
      "application/json" = ["dev.zed.Zed.desktop"];
      "text/plain" = ["dev.zed.Zed.desktop"];
      "text/markdown" = ["dev.zed.Zed.desktop"];

      # Teams protocol
      "x-scheme-handler/msteams" = ["teams-for-linux.desktop"];

      # Browser defaults
      "text/html" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/http" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/https" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/about" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/unknown" = ["app.zen_browser.zen.desktop"];
      "application/xhtml+xml" = ["app.zen_browser.zen.desktop"];
      "application/xml" = ["app.zen_browser.zen.desktop"];
    };
  };
}
