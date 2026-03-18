{ inputs, ... }:

{

  programs.niri = {

    settings ={
      layer-rules = [
        {
          matches = [{ namespace = "^quickshell$"; }];
          place-within-backdrop = true;
        }
      ];

      binds = with inputs.niri-flake.lib; let
      # you can also define Mod = "Mod4"; here
      in {
        "Mod+O".action.toggle-overview = {};

        # Noctalia Specific
        # Check https://docs.noctalia.dev/getting-started/keybinds/ for more
        "Mod+D".action.spawn = [ "dms" "ipc" "call" "spotlight" "toggle" ];
        "Mod+S".action.spawn = [ "dms" "ipc" "call" "settings" "toggle" ];
        "Mod+V".action.spawn = [ "dms" "ipc" "call" "launcher" "clipboard" ];
        "Mod+Grave".action.spawn = [ "dms" "ipc" "call" "launcher" "emoji" ];
        "Mod+W".action.spawn = [ "dms" "ipc" "call" "wallpaper" "toggle" ];
        "Mod+Escape".action.spawn = [ "dms" "ipc" "call" "sessionMenu" "toggle" ];
        "Mod+L".action.spawn = [ "dms" "ipc" "call" "lock" "lock" ];

        # Volume controls
        "XF86AudioRaiseVolume".action.spawn = [ "dms" "ipc" "call" "audio" "increment" "10" ];
        "XF86AudioLowerVolume".action.spawn = [ "dms" "ipc" "call" "audio" "decrement" "10" ];
        "XF86AudioMute".action.spawn = [ "dms" "ipc" "call" "audio" "mute" ];

        "XF86AudioMicMute".action.spawn = [ "dms" "ipc" "call" "audio" "micmute" ];

        # Brightness
        "XF86MonBrightnessUp".action.spawn = [ "dms" "ipc" "call" "brightness" "increment" "10" ];
        "XF86MonBrightnessDown".action.spawn = [ "dms" "ipc" "call" "brightness" "decrement" "10" ];

        # Power profile
        # "XF86Favorites".action.spawn = [ "dms" "ipc" "call" "powerProfile" "cycle" ];
      };
    };
  };
}
