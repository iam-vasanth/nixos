{ paths,... }:{

  hjf = {
    ".config/mpv/shaders".source = paths.dots + /mpv/shaders;
    ".config/mpv/mpv.conf".source = paths.dots + /mpv/mpv.conf;
    ".config/mpv/input.conf".source = paths.dots + /mpv/input.conf;
  };
}
