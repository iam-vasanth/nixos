{
  config,
  lib,
  pkgs,
  unstable,
  impure,
  ...
}: {
  ###########################################################################
  # Kitty
  ###########################################################################

  options.program.kitty.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.program.kitty.enable {
    environment.systemPackages = [pkgs.kitty];

    hjf = {
      ".config/kitty/kitty.conf".source = impure.dots + "/kitty/kitty.conf";
    };
  };
}
