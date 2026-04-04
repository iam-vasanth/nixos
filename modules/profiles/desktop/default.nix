{
  config,
  user,
  pkgs,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./sops.nix
  ];

  ###########################################################################
  # Bootloader
  ###########################################################################

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  ###########################################################################
  # Kernal and Kernal parameters
  ###########################################################################

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.consoleLogLevel = 0;
  boot.initrd.systemd.enable = true;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "vt.global_cursor_default=0"
  ];

  ###########################################################################
  # Silences systemd logs
  ###########################################################################

  systemd = {
    services.NetworkManager-wait-online.enable = false;
    settings = {
      Manager = {
        ShowStatus = "no";
        DefaultStandardOutput = "null";
      };
    };
  };

  ###########################################################################
  # Swap file
  ###########################################################################

  # Waiting for nix Zswap implementation
  # https://github.com/NixOS/nixpkgs/pull/470366

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
      randomEncryption.enable = true; # False if hibernating
    }
  ];

  ###########################################################################
  # Enables flakes
  ###########################################################################

  nix.settings.experimental-features = ["nix-command" "flakes"];

  ###########################################################################
  # Unfree packages
  ###########################################################################

  nixpkgs.config.allowUnfree = true;

  ###########################################################################
  # User
  ###########################################################################

  sops.secrets.zoro-password.neededForUsers = true;
  users.mutableUsers = false;

  users.users.${user} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.zoro-password.path;
    description = "ZORO";
    extraGroups = ["networkmanager" "wheel" "docker" "adbusers" "fuse" "video" "libvirtd"];
  };

  ###########################################################################
  # Timezone
  ###########################################################################

  time.timeZone = "Asia/Kolkata";

  ###########################################################################
  # Networking
  ###########################################################################

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  hardware.bluetooth.enable = true;

  ###########################################################################
  # Sound - Pipewire
  ###########################################################################

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  ###########################################################################
  # Dynamically linked executable
  ###########################################################################

  programs.nix-ld.enable = true;

  ###########################################################################
  # ADB for android
  ###########################################################################

  programs.adb.enable = true;

  ###########################################################################
  # Android and Iphone mounting
  ###########################################################################

  # Android
  services.gvfs.enable = true;

  # Iphones
  services.usbmuxd.enable = true;

  ###########################################################################
  # Thermal management for intel processors
  ###########################################################################

  services.thermald.enable = true;

  ###########################################################################
  # Firmware updates
  ###########################################################################

  services.fwupd.enable = true;

  ###########################################################################
  # Fprintd
  ###########################################################################
  services.fprintd.enable = true;

  ###########################################################################
  # Enables flatpak
  ###########################################################################

  services.flatpak.enable = true;

  ###########################################################################
  # Localsend
  ###########################################################################

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  ###########################################################################
  # Docker
  ###########################################################################

  virtualisation.docker.enable = true;

  ###########################################################################
  # Virt-Manager
  ###########################################################################

  programs.virt-manager.enable = true;
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        vhostUserPackages = [pkgs.virtiofsd];
      };
    };
  };

  systemd.services.libvirt-default-network = {
    description = "Activate libvirt default network";
    after = ["libvirtd.service"];
    requires = ["libvirtd.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.libvirt}/bin/virsh net-autostart default
      ${pkgs.libvirt}/bin/virsh net-start default || true
    '';
  };

  ###########################################################################
  # Host specific common packages
  ###########################################################################

  environment.systemPackages = [
    pkgs.neovim
    pkgs.wget
    pkgs.gitFull
    pkgs.zed-editor
    pkgs.alacritty
    pkgs.fuse
    pkgs.wev
    pkgs.bibata-cursors
    # ... add more packages here

    # Android and IOS mounting
    pkgs.go-mtpfs
    pkgs.jmtpfs
    pkgs.libimobiledevice
    pkgs.ifuse
  ];

  ###########################################################################
  # Font packages
  ###########################################################################

  # It is already installed at home manager level - Comment out if needed at system level
  # fonts.packages = with pkgs; [
  #   nerd-fonts.jetbrains-mono
  #   nerd-fonts.fira-code
  #   fira-code-symbols
  #   nerd-fonts.iosevka
  #   nerd-fonts.hack
  #   inter-nerdfont
  # ];

  ###########################################################################
  # Nix cleanup
  ###########################################################################

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
  };

  ###########################################################################
  # Secure Boot (lanzaboote)
  ###########################################################################

  # Too scared to enable - Fuck Microslop
  #
  # boot.loader.systemd-boot.enable = lib.mkForce false;
  # boot.lanzaboote = {
  #   enable = true;
  #   pkiBundle = "/etc/secureboot";
  # };

  ###########################################################################
  # State version - Do not touch this
  ###########################################################################

  system.stateVersion = "25.11";
}
