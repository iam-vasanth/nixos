{
  lib,
  config,
  pkgs,
  unstable,
  ...
}: {
  ###########################################################################
  # Mango
  ###########################################################################

  imports = [
    #./mango-desktop-patch.nix
  ];
  options.wm.mango.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Mango compositor.";
  };

  config = lib.mkIf config.wm.mango.enable {
    hjf = {
      # ".config/mango/config.conf".source = paths.dots + /mango/config.conf;
      # ".config/noctalia/config.toml".source = paths.dots + /noctalia/niri/main-config.toml;
    };

    programs.mango = {
      enable = true;
      addLoginEntry = true;
    };
    environment.systemPackages = [
      pkgs.xwayland-satellite
    ];

    # xdg.portal = {
    #   enable = true;
    #   wlr.enable = true;
    #   extraPortals = [
    #     pkgs.kdePackages.xdg-desktop-portal-kde
    #     pkgs.xdg-desktop-portal-wlr
    #   ];
    #   config.mango = {
    #     default = lib.mkForce [ "kde" ];
    #     "org.freedesktop.impl.portal.ScreenCast" = "wlr";
    #     "org.freedesktop.impl.portal.Screenshot" = "wlr";
    #   };
    # };

    # systemd.user.targets.mango-session = {
    #   name = "Mango system session";
    #   description = "mango compositor session";
    #   bindsTo = [ "graphical-session.target" ];
    #   wants = [ "graphical-session-pre.target" ];
    #   after = [ "graphical-session-pre.target" ];
    # };
  };
}
