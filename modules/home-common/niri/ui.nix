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

      # Environment variables (handled by home.sessionVariables or systemd user env)
      # You can also set them via home.sessionVariables
    };
  };
}
