{ paths,... }:{

  hjf = {
    ".config/fastfetch/config.jsonc".source = paths.dots + /fastfetch/config.jsonc;
    ".config/fastfetch/ascii.txt".source = paths.dots + /fastfetch/ascii.txt;
  };
}
