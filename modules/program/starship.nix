{
  config,
  lib,
  pkgs,
  unstable,
  paths,
  ...
}: {
  ###########################################################################
  # Starship
  ###########################################################################

  options.program.starship.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.program.starship.enable {
    environment.systemPackages = [pkgs.starship];

    hjf = {
      ".config/starship.toml".source = paths.dots + /starship/starship.toml;
    };
  };
}
