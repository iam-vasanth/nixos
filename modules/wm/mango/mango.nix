{ inputs, lib, config, user, hostname, pkgs, unstable, paths, ... }:

{
  imports = [
  ];
  options.wm.mango.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Mango compositor.";
  };

  config = lib.mkIf config.wm.mango.enable {

    # hjf = {
    #   ".config/niri/config.kdl".source = paths.dots + /niri/config.kdl;
    #   ".config/noctalia/config.toml".source = paths.dots + /noctalia/niri/main-config.toml;
    # };

    programs.mango = {
      enable = true;
      addLoginEntry = true;
    };

    # xdg.portal = {
    #   config.niri = {
    #     default = lib.mkForce [ "kde" ];
    #     "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
    #     "org.freedesktop.portal.ScreenCast" = "wlr";
    #     "org.freedesktop.impl.portal.ScreenCast" = "wlr";
    #     "org.freedesktop.impl.portal.Screenshot" = "kde";
    #   };
    # };

    environment.systemPackages = [
      pkgs.xwayland-satellite
    ];
  };
}
