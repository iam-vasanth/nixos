{
  inputs,
  lib,
  config,
  user,
  pkgs,
  paths,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  ###########################################################################
  # Noctalia shell
  ###########################################################################

  options.programs.noctalia.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Noctalia shell";
  };

  config = lib.mkIf config.programs.noctalia.enable {
    hjem.extraModules = [inputs.noctalia.hjemModules.default];
    hj = {
      programs.noctalia = {
        enable = true;
        systemd = {
          enable = true;
          # target = "graphical-session.target";
        };
      };
      files = {
        "Pictures/.nix.png".source = paths.dots + /nix.png;
      };
    };

    ###########################################################################
    # Noctalia greeter and fallback options
    ###########################################################################

    programs.noctalia-greeter = {
      enable = true;
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
    #       command = "mango";
    #       user = user;
    #     };
    #     default_session = {
    #       command = "${pkgs.tuigreet}/bin/tuigreet --cmd mango";
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
