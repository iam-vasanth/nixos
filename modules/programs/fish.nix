{
  hostname,
  user,
  pkgs,
  ...
}: {
  ###########################################################################
  # Fish
  ###########################################################################

  programs.fish = {
    enable = true;

    # Disable default greeting
    interactiveShellInit = ''
      set fish_greeting
      nix-your-shell fish | source
      starship init fish | source
    '';

    # Aliases
    shellAliases = {
      c = "cd ..";
      ll = "ls -lAh";
      la = "ls -A";
      tree = "ls --tree";

      # Git
      lg = "lazygit";
      ld = "lazydocker";
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
      rebuild = "sudo nixos-rebuild switch --flake .#${hostname} --impure";
      nso = "sudo nix store optimise";
      ngc = "sudo nix-collect-garbage -d";
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

      # Virt-manager
      vmlist = "virsh -c qemu:///system list --all";
      vmip = "virsh -c qemu:///system domifaddr";

      ports = "ss -tuln";
      myip = "curl ifconfig.me";
      sshk = "kitty +kitten ssh";
    };
  };
  ###########################################################################
  # Set fish as the user's login shell
  ###########################################################################

  # users.users.${user}.shell = pkgs.fish;
}
