{...}: {
  ###########################################################################
  # Zathura
  ###########################################################################

  programs.zathura = {
    enable = true;

    options = {
      font = "JetBrainsMono Nerd Font 11";
      recolor-lightcolor = "#1e1e2e";
      recolor-darkcolor = "#cdd6f4";
      default-bg = "#1e1e2e";
      scroll-step = 50;
      selection-clipboard = "clipboard";
      window-title-basename = true;
    };

    mappings = {
      "<C-i>" = "recolor";
    };
  };
}
