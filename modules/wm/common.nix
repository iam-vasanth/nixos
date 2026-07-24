{ inputs, lib, config, user, pkgs, ... }:
let
  noRounding = ''
    * {
      border-radius: 0px !important;
    }

    window {
      border-radius: 0px !important;
    }

    window,
    decoration,
    decoration-overlay,
    headerbar,
    .titlebar {
      border-radius: 0px !important;
      border-bottom-left-radius: 0px !important;
      border-bottom-right-radius: 0px !important;
      border-top-left-radius: 0px !important;
      border-top-right-radius: 0px !important;
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

      # programs.uwsm = {
      #   enable = true;

      #   waylandCompositors = {
      #     niri = {
      #       prettyName = "Niri";
      #       comment = "Niri compositor managed by UWSM";
      #       binPath = "/run/current-system/sw/bin/niri-session";
      #     };

      #     mango = {
      #       prettyName = "MangoWM";
      #       comment = "MangoWM compositor managed by UWSM";
      #       binPath = "/run/current-system/sw/bin/mango";
      #     };
      #   };
      # };

      xdg = {
        terminal-exec = {
          enable = true;
          settings.default = [
            "kitty.desktop"
          ];
        };

        # portal = {
        #   enable = true;

        #   extraPortals = [
        #     pkgs.kdePackages.xdg-desktop-portal-kde
        #     pkgs.xdg-desktop-portal-gtk
        #     pkgs.xdg-desktop-portal-gnome
        #     pkgs.xdg-desktop-portal-termfilechooser
        #   ];
        # };
      };
    };
  }
