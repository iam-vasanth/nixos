{
  config,
  lib,
  pkgs,
  unstable,
  paths,
  ...
}: {
  ###########################################################################
  # Zathura
  ###########################################################################

  options.programs.zathura.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  environment.systemPackages = [pkgs.zathura];

  config = lib.mkIf config.programs.zathura.enable {
    hjf = {
      ".config/zathura/zathurarc".source = paths.dots + /zathura/zathurarc;
    };
  };
}
