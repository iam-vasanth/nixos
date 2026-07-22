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
    inputs.dms.nixosModules.dank-material-shell
    inputs.dms.nixosModules.greeter
  ];

  config = lib.mkIf (config.nix.desktop == "dms") {

###########################################################################
# NixOS-level modules
###########################################################################

    ###########################################################################
    # Enables DMS
    ###########################################################################

    programs.dank-material-shell = {
      enable = true;
      enableDynamicTheming = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      greeter = {
        enable = true;
        compositor.name = "niri";
        configHome = "/home/${user}";
      };
    };

    ###########################################################################
    # Enables Niri and GDM
    ###########################################################################

    programs.niri = {
      enable = true;
      # Uses the custom patched niri from above.
      package = unstable.niri;
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

    ###########################################################################
    # XDG Portals
    ###########################################################################

    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk # fallback for file pickers, etc.
        xdg-desktop-portal-gnome # required for screencast on Niri
      ];

      config = {
        common = {
          default = ["gtk"]; # GTK as general fallback

          # Force ScreenCast to use the GNOME backend.
          "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
        };
      };
    };

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
        inputs.dms.homeModules.dank-material-shell
        inputs.dms.homeModules.niri

        ../../home/common/etc.nix
        ../../home/common/mimeapps.nix
        ../../home/common/niri.nix
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

      programs.dank-material-shell.niri.includes.enable = false;

      ###########################################################################
      # Adds DMS zen theme to the zen default profile folder
      ###########################################################################

      home.activation.zenChrome = lib.hm.dag.entryAfter ["writeBoundary"] ''
        for PROFILE_DIR in \
            "$(find ~/.zen -maxdepth 1 -type d -name "*.Default Profile" 2>/dev/null | head -n 1)" \
            "$(find "$HOME/.config/zen" -maxdepth 1 -type d -name "*Default (release)" 2>/dev/null | head -n 1)" \
            "$(find "$HOME/.var/app/app.zen_browser.zen/.zen" -maxdepth 1 -type d -name "*Default (release)" 2>/dev/null | head -n 1)"
        do
            [ -z "$PROFILE_DIR" ] && continue
            mkdir -p "$PROFILE_DIR/chrome"
            ln -sf "$HOME/.config/DankMaterialShell/zen.css" "$PROFILE_DIR/chrome/userChrome.css"
        done
      '';

      ###########################################################################
      # Udiskie (For Auto USB/Device mounts)
      ###########################################################################

      services.udiskie.enable = true;

      ###########################################################################
      # Niri (DMS Specific)
      ###########################################################################

      programs.niri = {
        settings = {
          window-rules = [
            {
              geometry-corner-radius = {
                top-left = 10.0;
                top-right = 10.0;
                bottom-left = 10.0;
                bottom-right = 10.0;
              };
            }
          ];
          layer-rules = [
            {
              matches = [{namespace = "dms:blurwallpaper";}];
              place-within-backdrop = true;
            }
          ];
          binds = with inputs.niri-flake.lib; let
            # you can also define custom Mod key = "Mod4"; here
          in {
            "Mod+O".action.toggle-overview = {};
            "Mod+D".action.spawn = ["dms" "ipc" "call" "spotlight" "toggle"];
            "Mod+S".action.spawn = ["dms" "ipc" "call" "settings" "toggle"];
            "Mod+V".action.spawn = ["dms" "ipc" "call" "launcher" "clipboard"];
            "Mod+Grave".action.spawn = ["dms" "ipc" "call" "launcher" "emoji"];
            "Mod+W".action.spawn = ["dms" "ipc" "call" "wallpaper" "toggle"];
            "Mod+Escape".action.spawn = ["dms" "ipc" "call" "sessionMenu" "toggle"];
            "Mod+L".action.spawn = ["dms" "ipc" "call" "lock" "lock"];

            # Volume controls
            "XF86AudioRaiseVolume".action.spawn = ["dms" "ipc" "call" "audio" "increment" "10"];
            "XF86AudioLowerVolume".action.spawn = ["dms" "ipc" "call" "audio" "decrement" "10"];
            "XF86AudioMute".action.spawn = ["dms" "ipc" "call" "audio" "mute"];

            "XF86AudioMicMute".action.spawn = ["dms" "ipc" "call" "audio" "micmute"];

            # Brightness
            "XF86MonBrightnessUp".action.spawn = ["dms" "ipc" "call" "brightness" "increment" "10"];
            "XF86MonBrightnessDown".action.spawn = ["dms" "ipc" "call" "brightness" "decrement" "10"];
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
