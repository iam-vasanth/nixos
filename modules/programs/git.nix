{ paths,... }:{

  hjf = {
    ".gitconfig".source = paths.dots + /git/config;
    ".gitignore".source = paths.dots + /git/ignore;
  };
}
