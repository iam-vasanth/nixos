{ inputs, lib, config, user, pkgs, ... }:
let
  noRounding = ''
    @import url("noctalia.css");

    * {
      border-radius: 10px;
    }

    window {
      border-radius: 10px;
    }

    window,
    decoration,
    decoration-overlay,
    headerbar,
    .titlebar {
      border-radius: 10px;
      border-bottom-left-radius: 10px;
      border-bottom-right-radius: 10px;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
    }
  '';
in
{
    options.wm.common.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Wayland compositor.";
    };
    config = lib.mkIf config.wm.common.enable {

      hjf = {
        ".config/gtk-4.0/gtk.css".text = noRounding;
        ".config/gtk-3.0/gtk.css".text = noRounding;
      };

      xdg = {
        terminal-exec = {
          enable = true;
          settings.default = [
            "kitty.desktop"
          ];
        };

        portal = {
          enable = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-gnome
            pkgs.xdg-desktop-portal-termfilechooser
          ];
        };
      };
    };
  }
