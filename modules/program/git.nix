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

  options.program.git.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.program.git.enable {
    environment.systemPackages = [pkgs.gitFull];

    hjf = {
      ".gitconfig".source = paths.dots + /git/config;
      ".gitignore".source = paths.dots + /git/ignore;
    };
  };
}
