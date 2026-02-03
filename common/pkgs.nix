{ host, user, pkgs, lib, ... }:

{

  environment.systemPackages = [
    pkgs.neovim
    pkgs.wget
    pkgs.gitFull
    pkgs.zed-editor
    pkgs.alacritty
    pkgs.kitty
    pkgs.fuse
    pkgs.fuse3
    pkgs.firefox
    pkgs.nautilus
    pkgs.wev
    pkgs.bibata-cursors
    # pkgs.xwayland-satellite
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    fira-code-symbols
    nerd-fonts.iosevka
    nerd-fonts.hack
    inter-nerdfont
  ];

  # Power profile
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # To start dynamically linked executable
  programs.nix-ld.enable = true;

  # Enables flatpak
  services.flatpak.enable = true;

  # Enables docker
  virtualisation.docker.enable = true;

  # ADB support for android USB debugging
  programs.adb.enable = true;

  # Enables virt-manager for managing virtual machines
  programs.virt-manager.enable = true;
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
  };

  # Localsend
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  services.syncthing = {
    enable = true;
    user = "${user}";
    group = "users";
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
    dataDir = "/home/zoro/.syncthing";
    configDir = "/home/zoro/.config/syncthing";
  };
}
