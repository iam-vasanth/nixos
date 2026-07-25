{ pkgs, paths,... }:{

  hjf = {
    ".config/mpv/shaders".source = "${pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders";
    ".config/mpv".source = paths.dots + /mpv;
  };
}
