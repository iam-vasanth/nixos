{ ... }:

{
  programs.niri.settings.binds = {
    "Mod+T".action.spawn = "kitty";
    "Mod+E".action.spawn = "thunar";
    "Mod+B".action.spawn = "firefox";

    "Print".action.screenshot        = {};
    "Ctrl+Print".action.screenshot-screen = {};
    "Alt+Print".action.screenshot-window  = {};

    "Mod+Q".action.close-window      = {};
    "Mod+Left".action.focus-column-left   = {};
    "Mod+Down".action.focus-window-down   = {};
    "Mod+Up".action.focus-window-up       = {};
    "Mod+Right".action.focus-column-right = {};
    "Mod+Shift+Left".action.move-column-left   = {};
    "Mod+Shift+Down".action.move-window-down   = {};
    "Mod+Shift+Up".action.move-window-up       = {};
    "Mod+Shift+Right".action.move-column-right = {};

    "Mod+Ctrl+H".action.focus-monitor-left  = {};
    "Mod+Ctrl+J".action.focus-monitor-down  = {};
    "Mod+Ctrl+K".action.focus-monitor-up    = {};
    "Mod+Ctrl+L".action.focus-monitor-right = {};
    "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left  = {};
    "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down  = {};
    "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up    = {};
    "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};

    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;

    "Mod+R".action.switch-preset-column-width = {};
    "Mod+F".action.maximize-column             = {};
    "Mod+Shift+F".action.fullscreen-window     = {};
    "Mod+C".action.center-column               = {};
    "Mod+Minus".action.set-column-width        = "-10%";
    "Mod+Equal".action.set-column-width        = "+10%";
    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";

    "Mod+Comma".action.consume-window-into-column = {};
    "Mod+Period".action.expel-window-from-column  = {};

    "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
    "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
    "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
  };
}
