{...}: {
  ###########################################################################
  # Zathura
  ###########################################################################

  programs.zathura = {
    enable = true;

    options = {
      # Appearance
      font = "JetBrainsMono Nerd Font 11";
      recolor-lightcolor = "#1e1e2e";
      recolor-darkcolor = "#cdd6f4";
      default-bg = "#1e1e2e";

      # Behavior
      scroll-step = 50;
      selection-clipboard = "clipboard";
      window-title-basename = true;
    };

    mappings = {
      "<C-i>" = "recolor";
    };
  };
}
