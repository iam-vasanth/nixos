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

  options.programs.starship.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  environment.systemPackages = [pkgs.starship];

  config = lib.mkIf config.programs.starship.enable {
    hjf = {
      ".config/starship/starship.toml".source = paths.dots + /starship/starship.toml;
    };
  };
}
