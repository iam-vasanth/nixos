{ paths,... }:{

  hjf = {
    ".config/starship/starship.toml".source = paths.dots + /starship/starship.toml;
  };
}
