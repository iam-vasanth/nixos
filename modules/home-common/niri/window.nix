{ ... }:

{

  # ────────────────────────────────────────────────
  # Window / layer rules
  # ────────────────────────────────────────────────

  programs.niri = {
    settings.window-rules = [
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
  };
}
