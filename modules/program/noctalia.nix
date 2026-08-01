{
  inputs,
  lib,
  config,
  user,
  pkgs,
  paths,
  impure,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  ###########################################################################
  # Noctalia shell
  ###########################################################################

  options.program.noctalia.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Noctalia shell";
  };

  config = lib.mkIf config.program.noctalia.enable {
    hjem.extraModules = [inputs.noctalia.hjemModules.default];
    hjf = {
      ".config/noctalia/templates/lazyvim.lua" = {
        source = paths.dots + "/noctalia/templates/lazyvim.lua";
        type = "copy";
        permissions = "777";
      };
      "Pictures/.nix.png".source = paths.dots + /nix.png;
    };
    hj = {
      programs.noctalia = {
        enable = true;
        systemd = {
          enable = true;
          target = "graphical-session.target";
        };
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
