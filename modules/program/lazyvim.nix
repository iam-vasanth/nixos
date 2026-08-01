{
  config,
  lib,
  pkgs,
  impure,
  ...
}: {
  options.program.lazyvim.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.program.lazyvim.enable {
    environment.systemPackages = [
      pkgs.git
      pkgs.ripgrep
      pkgs.fd
      pkgs.gcc
      pkgs.unzip
      pkgs.gnumake
      pkgs.nodejs
      pkgs.lazygit
    ];

    programs.neovim.enable = true;

    hjf.".config/nvim".source = impure.dots + "/nvim";
  };
}
