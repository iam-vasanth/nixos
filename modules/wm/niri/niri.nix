{
  lib,
  pkgs,
  config,
  niri,
  hostname,
  ...
}:
{
  imports = [
    self.modules
    niri.nixosModules.default
  ];

  hjxdg = {
    "niri/config.kdl" = config.paths.dots + "/niri/${hostname}.kdl";
    "niri/noctalia.kdl" = config.paths.dots + "/niri/noctalia.kdl";
  };

  options.wm.niri.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
  };

  config = (lib.mkIf config.wm.niri.enable) {
    programs.niri = {
      enable = true;
      useNautilus = false;
      withUWSM = false;
      withXDG = false;
    };
  };

  xdg.portal = {
    config.niri = {
      default = [ "kde" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      "org.freedesktop.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "kde";
    };
  };

  environment.systemPackages = [
    pkgs.xwayland-satellite
  ];
}
