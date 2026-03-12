
programs.niri = {

    # ────────────────────────────────────────────────
    # Output / monitor settings
    # ────────────────────────────────────────────────
    output."eDP-1" = {
      mode = "3840x2160@60";
      scale = 2.0;
      # transform = "normal";   # uncomment if needed
      # position = { x = 0; y = 0; };
    };

    # ────────────────────────────────────────────────
    # Layout / gaps / animations / appearance
    # ────────────────────────────────────────────────
    layout = {
      gaps = 16;
      center-focused-column = "never";
      background-color = "#000000";

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5;     }
        { proportion = 0.66667; }
      ];

      default-column-width = { proportion = 0.5; };

      focus-ring = {
        active-color = "#bdc2ff";
        inactive-color = "#131316";
        urgent-color = "#ffb4ab";
      };

      border = {
        active-color = "#bdc2ff";
        inactive-color = "#131316";
        urgent-color = "#ffb4ab";
      };

      shadow.color = "#00000070";

      tab-indicator = {
        active-color = "#bdc2ff";
        inactive-color = "#353e90";
        urgent-color = "#ffb4ab";
      };

      insert-hint.color = "#bdc2ff80";
    };

    # Animations
    animations = {
      slowdown = 0.6;

      horizontal-view-movement = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 1200;
          epsilon = 0.0001;
        };
      };

      window-movement = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 1200;
          epsilon = 0.0001;
        };
      };

      window-resize = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 1200;
          epsilon = 0.0001;
        };
      };

      window-open = {
        duration-ms = 120;
        curve = "ease-out-cubic";
      };

      window-close = {
        duration-ms = 120;
        curve = "ease-out-cubic";
      };
    };

    # Cursor
    cursor = {
      xcursor-theme = "Bibata-Modern-Classic";
      xcursor-size = 24;
      hide-when-typing = false;   # not present in your config → defaults to false
      hide-after-inactive-ms = 10000;
    };

    # Misc
    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    # Environment variables (handled by home.sessionVariables or systemd user env)
    # You can also set them via home.sessionVariables
  };

  # ────────────────────────────────────────────────
  # Extra / raw KDL config that has no Nix equivalent yet
  # (very rare in recent niri versions)
  # ────────────────────────────────────────────────
  # extraConfig = ''
  #   some unsupported kdl here
  # '';

  # ────────────────────────────────────────────────
  # Keybindings (very similar to your original)
  # ────────────────────────────────────────────────
  settings.binds = with inputs.niri.lib; let
    # you can also define Mod = "Mod4"; here
  in {
    "Mod+O".action = "toggle-overview";

    # Launcher / Noctalia-style helpers
    "Mod+D".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
    "Mod+S".action.spawn = [ "noctalia-shell" "ipc" "call" "settings" "toggle" ];
    "Mod+V".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "clipboard" ];
    "Mod+Grave".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "emoji" ];
    "Mod+W".action.spawn = [ "noctalia-shell" "ipc" "call" "wallpaper" "toggle" ];
    "Mod+Escape".action.spawn = [ "noctalia-shell" "ipc" "call" "sessionMenu" "toggle" ];
    "Mod+L".action.spawn = [ "noctalia-shell" "ipc" "call" "lockScreen" "lock" ];

    # Volume (media keys)
    "XF86AudioRaiseVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "increase" ];
    "XF86AudioLowerVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "decrease" ];
    "XF86AudioMute".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteOutput" ];

    "Mod+XF86AudioRaiseVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "increaseInput" ];
    "Mod+XF86AudioLowerVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "decreaseInput" ];
    "XF86AudioMicMute".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteInput" ];

    # Brightness
    "XF86MonBrightnessUp".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "increase" ];
    "XF86MonBrightnessDown".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "decrease" ];

    # Power profile
    "XF86Favorites".action.spawn = [ "noctalia-shell" "ipc" "call" "powerProfile" "cycle" ];

    # Apps
    "Mod+T".action.spawn = "kitty";
    "Mod+E".action.spawn = "thunar";
    "Mod+B".action.spawn = "firefox";

    # Screenshots
    "Print".action = "screenshot";
    "Ctrl+Print".action = "screenshot-screen";
    "Alt+Print".action = "screenshot-window";

    # Window management
    "Mod+Q".action = "close-window";

    "Mod+Left".action  = "focus-column-left";
    "Mod+Down".action  = "focus-window-down";
    "Mod+Up".action    = "focus-window-up";
    "Mod+Right".action = "focus-column-right";

    "Mod+Shift+Left".action  = "move-column-left";
    "Mod+Shift+Down".action  = "move-window-down";
    "Mod+Shift+Up".action    = "move-window-up";
    "Mod+Shift+Right".action = "move-column-right";

    # Monitor navigation
    "Mod+Ctrl+H".action = "focus-monitor-left";
    "Mod+Ctrl+J".action = "focus-monitor-down";
    "Mod+Ctrl+K".action = "focus-monitor-up";
    "Mod+Ctrl+L".action = "focus-monitor-right";

    "Mod+Shift+Ctrl+H".action = "move-column-to-monitor-left";
    "Mod+Shift+Ctrl+J".action = "move-column-to-monitor-down";
    "Mod+Shift+Ctrl+K".action = "move-column-to-monitor-up";
    "Mod+Shift+Ctrl+L".action = "move-column-to-monitor-right";

    # Workspaces (1–9)
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    # ... up to 9

    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;
    # ... up to 9

    # Sizing
    "Mod+R".action = "switch-preset-column-width";
    "Mod+F".action = "maximize-column";
    "Mod+Shift+F".action = "fullscreen-window";
    "Mod+C".action = "center-column";

    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";

    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";

    # Scratchpad-like
    "Mod+Comma".action  = "consume-window-into-column";
    "Mod+Period".action = "expel-window-from-column";

    # Media (playerctl)
    "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
    "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
    "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
  };

  # ────────────────────────────────────────────────
  # Window / layer rules (very close to your .kdl)
  # ────────────────────────────────────────────────
  settings.window-rule = [
    {
      match.title = "Picture-in-Picture";
      open-floating = true;
    }
    {
      geometry-corner-radius = 15;
      clip-to-geometry = true;
    }
  ];

  settings.layer-rule = [
    {
      match.namespace = "^noctalia-overview.*";
      place-within-backdrop = true;
    }
  ];
};

# Recommended: let home-manager set environment variables
home.sessionVariables = {
  GDK_SCALE = "2";
  GDK_BACKEND = "wayland";
  QT_AUTO_SCREEN_SCALE_FACTOR = "0";
  QT_QPA_PLATFORM = "wayland";
  MOZ_ENABLE_WAYLAND = "1";
  XCURSOR_SIZE = "24";
  ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  NIXOS_OZONE_WL = "1";
};

# Optional: autostart noctalia-shell (if desired)
# home.packages = [ pkgs.some-noctalia-pkg ];  # ← adapt
# systemd.user.services.noctalia = { ... };
}
