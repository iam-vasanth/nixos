{
  config,
  lib,
  hostname,
  pkgs,
  unstable,
  impure,
  ...
}: {
  ###########################################################################
  # Niri
  ###########################################################################

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
      ".config/niri/config.kdl".source = impure.dots + "/niri/${hostname}/config.kdl";
      ".config/noctalia/config.toml".source = impure.dots + "/noctalia/niri/${hostname}/main-config.toml";
    };

    programs.niri = {
      enable = true;
      package = unstable.niri;
    };

    environment.systemPackages = [
      pkgs.xwayland-satellite
    ];
  };
}
