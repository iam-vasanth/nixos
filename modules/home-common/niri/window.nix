{ ... }:

{

  # ────────────────────────────────────────────────
  # Window / layer rules (very close to your .kdl)
  # ────────────────────────────────────────────────

  program.niri = {
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
}
