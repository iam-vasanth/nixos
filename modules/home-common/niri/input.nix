{ ... }:

{

  # ────────────────────────────────────────────────
  # Input / keyboard / touchpad settings
  # ────────────────────────────────────────────────

  programs.niri = {

    settings = {
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

        warp-mouse-to-focus = true;
        focus-follows-mouse = "max-scroll-amount=\"0%\"";
        disable-power-key-handling = true;
      };
    };
  };
}
