{ ... }:

{

  # ────────────────────────────────────────────────
  # Layout / gaps / animations / appearance
  # ────────────────────────────────────────────────

  programs.niri = {
    settings = {
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

      cursor = {
        xcursor-theme = "Bibata-Modern-Classic";
        xcursor-size = 24;
        hide-when-typing = false;
        hide-after-inactive-ms = 10000;
      };

      # Misc
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
      # screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      # Environment variables (handled by home.sessionVariables or systemd user env)
      # You can also set them via home.sessionVariables
    };
  };
}
