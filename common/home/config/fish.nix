{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    # Disable default greeting
    interactiveShellInit = ''
      set fish_greeting
      nix-your-shell fish | source
    '';

    # Aliases
    shellAliases = {
      c = "cd ..";
      ll = "ls -lAh";
      la = "ls -A";
      tree = "ls --tree";

      # Git
      lg = "lazygit";
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit -m";
      gco = "git checkout";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      glog = "git log --oneline --graph --decorate";

      # Nix
      rebuild = "sudo nixos-rebuild switch --impure --flake .";
      hms = "home-manager switch --impure --flake .";
      ngc = "nix-collect-garbage -d";
      nsearch = "nix search nixpkgs";

      # Tools
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ip = "ip --color=auto";

      # Containers
      d = "docker";
      dc = "docker compose";
      dcu = "docker compose up -d";
      dcd = "docker compose down";

      ports = "ss -tuln";
      myip = "curl ifconfig.me";
    };

    plugins = [
      { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }         # Fuzzy git interactive
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }     # fzf for history/files/git
      { name = "done"; src = pkgs.fishPlugins.done.src; }             # Notifications for long commands
      { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }     # Auto-close brackets/quotes
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }               # Colorize command output
    ];
  };
}
