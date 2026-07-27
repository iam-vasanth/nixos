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

  options.programs.fastfetch.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  environment.systemPackages = [pkgs.fastfetch];

  config = lib.mkIf config.programs.fastfetch.enable {
    hjf = {
      ".config/fastfetch/config.jsonc".source = paths.dots + /fastfetch/config.jsonc;
      ".config/fastfetch/ascii.txt".source = paths.dots + /fastfetch/ascii.txt;
    };
  };
}
