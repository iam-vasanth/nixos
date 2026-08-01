{
  config,
  lib,
  pkgs,
  unstable,
  impure,
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
      ".gitconfig".source = impure.dots + "/git/config";
      ".gitignore".source = impure.dots + "/git/ignore";
      ".config/lazygit/config.yml".source = impure.dots + "/lazygit/config.yml";
    };
  };
}
