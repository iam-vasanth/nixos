{ ... }:

{

  # ────────────────────────────────────────────────
  # Output / monitor settings
  # ────────────────────────────────────────────────

  programs.niri.settings.outputs = {
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
}
