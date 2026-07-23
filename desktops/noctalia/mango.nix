{
  config,
  lib,
  inputs,
  user,
  pkgs,
  unstable,
  ...
}:
{
  imports = [

  ];

  programs.mango = {
    enable = true;
    addLoginEntry = true;
  };

  services.greetd = {
    enable = true;

    settings.default_session = {
      command = ''
        ${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --remember \
          --remember-session \
          --asterisks
      '';
      user = "greeter";
    };
  };

###########################################################################
# Home-level modules
###########################################################################

  home-manager.users.${user} = {lib, ...}: {
    imports = [
      ../../home/common/etc.nix
      ../../home/common/mimeapps.nix
      ../../home/common/pkgs.nix

      ../../home/programs/fastfetch.nix
      ../../home/programs/fish.nix
      ../../home/programs/fastfetch.nix
      ../../home/programs/git.nix
      ../../home/programs/kitty.nix
      ../../home/programs/ssh.nix
      ../../home/programs/starship.nix
      ../../home/programs/zed.nix
      ../../home/programs/zathura.nix
    ];

    ###########################################################################
    # Udiskie (For Auto USB/Device mounts)
    ###########################################################################

    services.udiskie = {
      enable = true;
      tray = "never";
      notify = false;
    };
  };
}
