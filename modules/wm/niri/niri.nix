{ inputs, lib, config, user, hostname, pkgs, unstable, paths, ... }:

{
  imports = [
    ./niri-session-patch.nix
  ];
  options.wm.niri.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Niri compositor.";
  };

  config = lib.mkIf config.wm.niri.enable {

    hjf = {
      ".config/niri/config.kdl".source = paths.dots + /niri/config.kdl;
      ".config/noctalia/config.toml".source = paths.dots + /noctalia/niri.toml;
    };

    programs.niri = {
      enable = true;
      package = unstable.niri;
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
