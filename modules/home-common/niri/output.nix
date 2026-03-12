{ ... }:

{

  # ────────────────────────────────────────────────
  # Output / monitor settings
  # ────────────────────────────────────────────────

  programs.niri = {
    output."eDP-1" = {
      mode = "3840x2160@60";
      scale = 2.0;
      # transform = "normal";   # uncomment if needed
      # position = { x = 0; y = 0; };
    };
  };
}
