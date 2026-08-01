{
  config,
  lib,
  pkgs,
  unstable,
  impure,
  ...
}: {
  ###########################################################################
  # Zathura
  ###########################################################################

  options.program.zathura.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.program.zathura.enable {
    environment.systemPackages = [pkgs.zathura];

    hjf = {
      ".config/zathura/zathurarc".source = impure.dots + "/zathura/zathurarc";
    };
  };
}
