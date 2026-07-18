{
  lib,
  inputs,
  unstable,
  ...
}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    # Import nixos or home modules if needed ...
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
      layer-rules = [
        {
          matches = [{namespace = "^quickshell$";}];
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
}
