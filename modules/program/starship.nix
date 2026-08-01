{
  config,
  lib,
  pkgs,
  unstable,
  impure,
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
      ".config/starship.toml".source = impure.dots + "/starship/starship.toml";
    };
  };
}
