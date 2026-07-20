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
    inputs.noctalia.nixosModules.default
  ];

  config = lib.mkIf (config.nix.desktop == "noctalia") {

###########################################################################
# NixOS-level modules
###########################################################################

    ###########################################################################
    # Noctalia shell
    ###########################################################################

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
      systemd.enable = true;
    };

    # Noctalia cache
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };

    ###########################################################################
    # Enables Niri and GDM
    ###########################################################################

    programs.niri = {
      enable = true;
      package = unstable.niri;
    };

    services.sysc-greet = {
      enable = true;
      compositor = "niri";
    };

    # GDM auto login
    # services.displayManager = {
    #   autoLogin = {
    #     enable = true;
    #     user = "${user}";
    #   };
    #   gdm = {
    #     enable = true;
    #     wayland = true;
    #     autoSuspend = false;
    #   };
    # };

    # Uncomment if using LUKS with GDM autologin for auto keyring unlock.
    # services.gnome.gnome-keyring.enable = true;

    services.gnome.gcr-ssh-agent.enable = false;

    # Disabled default polkit to use DMS's built-in polkit
    systemd.user.services.niri-flake-polkit.enable = false;

    ###########################################################################
    # Power profile
    ###########################################################################

    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    ###########################################################################
    # XDG Portals
    ###########################################################################

    # xdg.portal = {
    #   enable = true;

    #   extraPortals = with pkgs; [
    #     xdg-desktop-portal-gtk # fallback for file pickers, etc.
    #     xdg-desktop-portal-gnome # required for screencast on Niri
    #   ];

    #   config = {
    #     common = {
    #       default = ["gtk"]; # GTK as general fallback

    #       # Force ScreenCast to use the GNOME backend.
    #       "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
    #     };
    #   };
    # };

    ###########################################################################
    # USB handling
    ###########################################################################

    services.udisks2.enable = true;

    ###########################################################################
    # NixOS state version - Do not touch this
    ###########################################################################

    system.stateVersion = "26.05";

###########################################################################
# Home-level modules
###########################################################################

    home-manager.users.${user} = {lib, ...}: {
      imports = [
        inputs.noctalia.homeModules.default

        ../../modules/home/common/etc.nix
        ../../modules/home/common/mimeapps.nix
        ../../modules/home/common/niri.nix
        ../../modules/home/common/pkgs.nix

        ../../modules/home/programs/fastfetch.nix
        ../../modules/home/programs/fish.nix
        ../../modules/home/programs/fastfetch.nix
        ../../modules/home/programs/git.nix
        ../../modules/home/programs/kitty.nix
        ../../modules/home/programs/ssh.nix
        ../../modules/home/programs/starship.nix
        ../../modules/home/programs/zed.nix
      ];

      ###########################################################################
      # Noctalia shell (Home)
      ###########################################################################

      programs.noctalia.settings = {
        launch_apps_as_systemd_services = true;
      };

      ###########################################################################
      # Niri (Noctalia Specific)
      ###########################################################################

      programs.niri = {
        settings = {
          # spawn-at-startup = [
          #   {
          #     command = [
          #       "noctalia"
          #     ];
          #   }
          # ];
          layer-rules = [
            {
              matches = [{namespace = "^noctalia-backdrop";}];
              place-within-backdrop = true;
            }
          ];
          window-rules = [
            {
              matches = [{app-id="dev.noctalia.Noctalia";}];
              open-floating = true;
              default-column-width = {fixed = 1080;};
              default-window-height = {fixed = 920;};
            }
          ];
          binds = with inputs.niri.lib; let
            # you can also define custom Mod key = "Mod4"; here
          in {
            "Mod+O".action.toggle-overview = [];

            "Mod+D".action.spawn = ["noctalia" "msg" "panel-toggle" "launcher"];
            "Mod+S".action.spawn = ["noctalia" "msg" "settings-toggle"];
            "Mod+V".action.spawn = ["noctalia" "msg" "panel-toggle" "clipboard"];
            "Mod+Grave".action.spawn = ["noctalia" "msg" "panel-toggle" "launcher" "/emoji"];
            "Mod+W".action.spawn = ["noctalia" "msg" "panel-toggle" "wallpaper"];
            "Mod+Escape".action.spawn = ["noctalia" "msg" "panel-toggle" "session"];
            "Alt+Tab".action.spawn = ["noctalia" "msg" "window-switcher"];
            "Mod+L".action.spawn = ["noctalia" "msg" "session" "lock"];

            # Volume controls
            "XF86AudioRaiseVolume".action.spawn = ["noctalia" "msg" "volume-up" "10"];
            "XF86AudioLowerVolume".action.spawn = ["noctalia" "msg" "volume-down" "10"];
            "XF86AudioMute".action.spawn = ["noctalia" "msg" "volume-mute"];

            "Mod+XF86AudioRaiseVolume".action.spawn = ["noctalia" "msg" "mic-volume-up" "10%"];
            "Mod+XF86AudioLowerVolume".action.spawn = ["noctalia" "msg" "mic-volume-down" "10%"];
            "XF86AudioMicMute".action.spawn = ["noctalia" "msg" "mic-mute"];

            # Brightness
            "XF86MonBrightnessUp".action.spawn = ["noctalia" "msg" "brightness-up" "*" "5%"];
            "XF86MonBrightnessDown".action.spawn = ["noctalia" "msg" "brightness-down" "*" "5%"];

            # Power profile
            "XF86Favorites".action.spawn = ["noctalia" "msg" "power-cycle"];
          };
          debug = {
            honor-xdg-activation-with-invalid-serial = [];
          };
        };
      };
      ###########################################################################
      # Home state version - Do not touch this
      ###########################################################################

      home.stateVersion = "26.05";
    };
  };
}
