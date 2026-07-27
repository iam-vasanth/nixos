{
  config,
  lib,
  pkgs,
  unstable,
  paths,
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
      ".config/fastfetch/config.jsonc".source = paths.dots + /fastfetch/config.jsonc;
      ".config/fastfetch/ascii.txt".source = paths.dots + /fastfetch/ascii.txt;
    };
  };
}
