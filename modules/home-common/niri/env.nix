{ ... }:

{

  # ────────────────────────────────────────────────
  # Environment Variables
  # ────────────────────────────────────────────────

  programs.niri.settings.environment = {
    GDK_SCALE = "2";
    # GDK_BACKEND = "wayland";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "0";
    # QT_QPA_PLATFORM = "wayland";
    # MOZ_ENABLE_WAYLAND = "1";
    # XCURSOR_SIZE = "24";
    # ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
  };
}
