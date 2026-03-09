{ ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Images – Loupe
      "image/jpeg"       = [ "org.gnome.Loupe.desktop" ];
      "image/png"        = [ "org.gnome.Loupe.desktop" ];
      "image/gif"        = [ "org.gnome.Loupe.desktop" ];
      "image/webp"       = [ "org.gnome.Loupe.desktop" ];
      "image/bmp"        = [ "org.gnome.Loupe.desktop" ];
      "image/svg+xml"    = [ "org.gnome.Loupe.desktop" ];
      "image/tiff"       = [ "org.gnome.Loupe.desktop" ];
      "image/heic"       = [ "org.gnome.Loupe.desktop" ];
      "image/heif"       = [ "org.gnome.Loupe.desktop" ];

      # Code/data formats – Zed
      "application/json" = [ "dev.zed.Zed.desktop" ];
      "text/plain"       = [ "dev.zed.Zed.desktop" ];
      "text/markdown"    = [ "dev.zed.Zed.desktop" ];

      # Teams protocol
      "x-scheme-handler/msteams" = [ "teams-for-linux.desktop" ];

      # Browser defaults
      "text/html"                        = [ "app.zen_browser.zen.desktop" ];
      "x-scheme-handler/http"            = [ "app.zen_browser.zen.desktop" ];
      "x-scheme-handler/https"           = [ "app.zen_browser.zen.desktop" ];
      "x-scheme-handler/about"           = [ "app.zen_browser.zen.desktop" ];
      "x-scheme-handler/unknown"         = [ "app.zen_browser.zen.desktop" ];
      "application/xhtml+xml"            = [ "app.zen_browser.zen.desktop" ];
      "application/xml"                  = [ "app.zen_browser.zen.desktop" ];
    };
  };
}
