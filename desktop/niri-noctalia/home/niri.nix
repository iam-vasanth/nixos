{ inputs, ... }:

{

  program.niri = {

    settings ={

      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
          ];
        }
      ];

      binds = with inputs.niri.lib; let
      # you can also define Mod = "Mod4"; here
      in {
        "Mod+O".action = "toggle-overview";

        # Noctalia Specific
        # Check https://docs.noctalia.dev/getting-started/keybinds/ for more
        "Mod+D".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
        "Mod+S".action.spawn = [ "noctalia-shell" "ipc" "call" "settings" "toggle" ];
        "Mod+V".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "clipboard" ];
        "Mod+Grave".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "emoji" ];
        "Mod+W".action.spawn = [ "noctalia-shell" "ipc" "call" "wallpaper" "toggle" ];
        "Mod+Escape".action.spawn = [ "noctalia-shell" "ipc" "call" "sessionMenu" "toggle" ];
        "Mod+L".action.spawn = [ "noctalia-shell" "ipc" "call" "lockScreen" "lock" ];

        # Volume controls
        "XF86AudioRaiseVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "increase" ];
        "XF86AudioLowerVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "decrease" ];
        "XF86AudioMute".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteOutput" ];

        "Mod+XF86AudioRaiseVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "increaseInput" ];
        "Mod+XF86AudioLowerVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "decreaseInput" ];
        "XF86AudioMicMute".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteInput" ];

        # Brightness
        "XF86MonBrightnessUp".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "increase" ];
        "XF86MonBrightnessDown".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "decrease" ];

        # Power profile
        "XF86Favorites".action.spawn = [ "noctalia-shell" "ipc" "call" "powerProfile" "cycle" ];
      };
    };
  };
}
