{ ... }:

{

  ###########################################################################
  # Niri settings (Universal)
  ###########################################################################

  programs.niri = {
    settings = {

      ###########################################################################
      # Input / keyboard / touchpad settings
      ###########################################################################

      input = {
        keyboard = {
          xkb = {
            layout = "us";
          };
          repeat-delay = 600;
          repeat-rate = 25;
          track-layout = "global";
        };

        touchpad = {
          tap = true;
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          accel-speed = 0.2;
          accel-profile = "adaptive";
          scroll-method = "two-finger";
        };

        mouse = {
          accel-speed = 0;
          accel-profile = "flat";
        };

        touch = {
          map-to-output = "eDP-1";
        };

        warp-mouse-to-focus.enable = true;
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
      };

      ###########################################################################
      # Output / monitor settings
      ###########################################################################

      outputs = {
        "eDP-1" = {
          scale = 2.0;
          mode  = {
            width   = 3840;
            height  = 2160;
            refresh = 60.0;
          };
        };
        # transform = "normal";
        # position = { x = 0; y = 0; };
      };

      ###########################################################################
      # Window / layer rules
      ###########################################################################

      window-rules = [
        {
          matches = [{ title = "Picture-in-Picture"; }];
          open-floating = true;
        }
        {
          geometry-corner-radius = {
            top-left     = 15.0;
            top-right    = 15.0;
            bottom-left  = 15.0;
            bottom-right = 15.0;
          };
          clip-to-geometry = true;
        }
      ];

      ###########################################################################
      # Layout / gaps / animations / appearance
      ###########################################################################

      layout = {
        gaps = 16;
        center-focused-column = "never";
        # background-color = ""
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5;     }
          { proportion = 0.66667; }
        ];
        default-column-width = { proportion = 0.5; };
        focus-ring = {
          enable = true;
          width = 2;
          active.color   = "#bdc2ff";
          inactive.color = "#131316";
          urgent.color   = "#ffb4ab";
        };
        border = {
          enable = true;
          width = 2;
          active.color   = "#bdc2ff";
          inactive.color = "#131316";
          urgent.color   = "#ffb4ab";
        };
        shadow = {
          enable = true;
          color  = "#00000070";
        };
        tab-indicator = {
          enable = true;
          active.color = "#bdc2ff";
          inactive.color  = "#353e90";
          urgent.color = "#ffb4ab";
        };
        insert-hint = {
          enable  = true;
          display.color = "#bdc2ff80";
        };
      };

      animations = {
        slowdown = 0.6;
        horizontal-view-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness     = 1200;
          epsilon       = 0.0001;
        };
        window-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness     = 1200;
          epsilon       = 0.0001;
        };
        window-resize = {
          kind.easing = {
            duration-ms = 120;
            curve       = "ease-out-cubic";
          };
        };
        window-open = {
          kind.easing = {
            duration-ms = 120;
            curve       = "ease-out-cubic";
          };
        };
        window-close = {
          kind.easing = {
          duration-ms = 120;
          curve       = "ease-out-cubic";
        };
      };
      };

      cursor = {
        theme          = "Bibata-Modern-Classic";
        size           = 24;
        hide-when-typing       = false;
        hide-after-inactive-ms = 10000;
      };

      prefer-no-csd                    = true;
      hotkey-overlay.skip-at-startup   = true;
      # screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      ###########################################################################
      # Keybindings
      ###########################################################################

      binds = {
        "Mod+T".action.spawn = "kitty";
        "Mod+E".action.spawn = "thunar";
        "Mod+B".action.spawn = "firefox";

        "Print".action.screenshot        = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Alt+Print".action.screenshot-window  = {};

        "Mod+Q".action.close-window      = {};
        "Mod+Left".action.focus-column-left   = {};
        "Mod+Down".action.focus-window-down   = {};
        "Mod+Up".action.focus-window-up       = {};
        "Mod+Right".action.focus-column-right = {};
        "Mod+Shift+Left".action.move-column-left   = {};
        "Mod+Shift+Down".action.move-window-down   = {};
        "Mod+Shift+Up".action.move-window-up       = {};
        "Mod+Shift+Right".action.move-column-right = {};

        "Mod+Ctrl+H".action.focus-monitor-left  = {};
        "Mod+Ctrl+J".action.focus-monitor-down  = {};
        "Mod+Ctrl+K".action.focus-monitor-up    = {};
        "Mod+Ctrl+L".action.focus-monitor-right = {};
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left  = {};
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down  = {};
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up    = {};
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;

        "Mod+R".action.switch-preset-column-width = {};
        "Mod+F".action.maximize-column             = {};
        "Mod+Shift+F".action.fullscreen-window     = {};
        "Mod+C".action.center-column               = {};
        "Mod+Minus".action.set-column-width        = "-10%";
        "Mod+Equal".action.set-column-width        = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+Comma".action.consume-window-into-column = {};
        "Mod+Period".action.expel-window-from-column  = {};

        "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
        "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
        "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
      };

      ###########################################################################
      # Environment Variables
      ###########################################################################

      environment = {
        # XDG_CURRENT_DESKTOP = "niri";
        # GDK_SCALE = "2";
        GDK_BACKEND = "wayland";
        GTK_USE_PORTAL = "1";
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
        QT_AUTO_SCREEN_SCALE_FACTOR = "0";
        QT_QPA_PLATFORM = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        NIXOS_OZONE_WL = "1";
      };

      ###########################################################################
      # Extra / raw KDL config that has no Nix equivalent yet
      ###########################################################################

      # extraConfig = ''
      #   some unsupported kdl here
      # '';
  };
}
