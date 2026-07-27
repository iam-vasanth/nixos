{
  config,
  lib,
  pkgs,
  unstable,
  paths,
  ...
}: {
  ###########################################################################
  # Git
  ###########################################################################

  options.programs.git.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  environment.systemPackages = [pkgs.gitFull];

  config = lib.mkIf config.programs.git.enable {
    hjf = {
      ".gitconfig".source = paths.dots + /git/config;
      ".gitignore".source = paths.dots + /git/ignore;
    };
  };
}
