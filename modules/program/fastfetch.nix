{
  config,
  lib,
  pkgs,
  unstable,
  impure,
  ...
}: {
  ###########################################################################
  # Fastfetch
  ###########################################################################

  options.program.fastfetch.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.program.fastfetch.enable {
    environment.systemPackages = [pkgs.fastfetch];

    hjf = {
      ".config/fastfetch/config.jsonc".source = impure.dots + "/fastfetch/config.jsonc";
      ".config/fastfetch/ascii.txt".source = impure.dots + "/fastfetch/ascii.txt";
    };
  };
}
