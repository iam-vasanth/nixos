{ inputs, lib, config, user, hostname, pkgs, paths, ... }:

{
  options.wm.niri.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Niri compositor.";
  };

  config = lib.mkIf config.wm.niri.enable {
    hjf = {
      "niri/config.kdl".source = paths.dots + "/niri/${hostname}.kdl";
      # "niri/noctalia.kdl".source = paths.dots + "/niri/noctalia.kdl";
    };

    programs.niri.enable = true;

    xdg.portal = {
      config.niri = {
        default = [ "kde" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
        "org.freedesktop.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "kde";
      };
    };

    environment.systemPackages = [
      pkgs.xwayland-satellite
    ];
  };
}
