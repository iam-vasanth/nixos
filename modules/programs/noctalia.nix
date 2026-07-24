{ inputs, lib, config, user, pkgs, ... }:{
  options.programs.noctalia.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Noctalia shell.";
  };

  config = lib.mkIf config.programs.noctalia.enable {
    hj = {
      programs.noctalia = {
        enable = true;
        systemd = {
          enable = true;
          target = "graphical-session.target";
        };
      };
      # xdg.config.files = {
      #   "noctalia/config.toml".source = paths.dots + "/noctalia/config.toml";
      # };
    };

    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "niri";
          user = user;
        };
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri";
          user = "greeter";
        };
      };
    };
  };
}
