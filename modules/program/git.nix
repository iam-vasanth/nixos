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
    environment.systemPackages = [pkgs.gitFull pkgs.lazygit];

    hjf = {
      ".gitconfig".source = paths.dots + /git/config;
      ".gitignore".source = paths.dots + /git/ignore;
      ".config/lazygit/config.yml".source = paths.dots + /lazygit/config.yml;
    };
  };
}
