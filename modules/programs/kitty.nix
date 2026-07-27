{
  config,
  lib,
  pkgs,
  unstable,
  paths,
  ...
}: {
  ###########################################################################
  # Kitty
  ###########################################################################

  options.programs.kitty.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  environment.systemPackages = [pkgs.kitty];

  config = lib.mkIf config.programs.kitty.enable {
    hjf = {
      ".config/kitty/kitty.conf".source = paths.dots + /kitty/kitty.conf;
    };
  };
}
