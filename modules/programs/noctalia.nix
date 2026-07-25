{ inputs, lib, config, user, pkgs, paths, ... }:{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];
  options.programs.noctalia.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Noctalia shell.";
  };

  config = lib.mkIf config.programs.noctalia.enable {
    hjem.extraModules = [ inputs.noctalia.hjemModules.default ];
    hj = {
      programs.noctalia = {
        enable = true;
        systemd = {
          enable = true;
          target = "graphical-session.target";
        };
      };
      files = {
        "Pictures/.nix.png".source = paths.dots + /nix.png;
      #   "noctalia/config.toml".source = paths.dots + "/noctalia/config.toml";
      };
    };

    programs.noctalia-greeter = {
      enable = true;

      # Optional configuration
      greeter-args = "";
      settings = {
        cursor = {
          theme = "Bibata-Modern-Classic";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
        keyboard = {
          layout = "us";
        };
      };
    };

    # services.greetd = {
    #   enable = true;
    #   settings = {
    #     initial_session = {
    #       command = "niri-session";
    #       user = user;
    #     };
    #     default_session = {
    #       command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
    #       user = "greeter";
    #     };
    #   };
    # };

    # services.displayManager = {
    #   autoLogin = {
    #     enable = true;
    #     user = "${user}";
    #   };
    #   gdm = {
    #     enable = true;
    #     autoSuspend = false;
    #   };
    # };
  };
}
