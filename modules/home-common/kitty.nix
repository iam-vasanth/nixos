{ ... }:

{
  programs.kitty = {
    enable = true;

    shellIntegration = {
      enableFishIntegration = true;
    };

    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 13.0;
    };

    settings = {
      shell = "fish";
      enable_audio_bell = false;
      cursor_shape = "block";
      cursor_blink_interval = 0;
      scrollback_lines = 10000;
      window_padding_width = "5 5 5 5";
      window_margin_width = 5;
      single_window_margin_width = -1;
      tab_bar_style = "powerline";
      tab_bar_align = "left";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      background_opacity = "0.95";
    };
    keybindings = {
      "alt+t" = "new_tab";
      "alt+right" = "next_tab";
      "alt+left" = "previous_tab";
      "alt+q" = "close_tab";
      "ctrl+equal" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+0" = "change_font_size all 0";
    };

    # Theme file
    extraConfig = ''
      include themes/noctalia.conf
      include dank-theme.conf
      include dank-tabs.conf
    '';
  };
}
