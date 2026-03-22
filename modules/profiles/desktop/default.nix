{
  config,
  pkgs,
  lib,
  inputs,
  user,
  hostname,
  ...
}: {
  # ── External imports ───────────────────────────────────────────────────────────
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./sops.nix
  ];

  # ── Bootloader ───────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 20;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── Kernal ───────────────────────────────────────────────────────────
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # ── Kernal Parameters ───────────────────────────────────────────────────────────
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

  # ── Silences systemd logs ───────────────────────────────────────────────────────────
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    settings = {
      Manager = {
        ShowStatus = "no";
        DefaultStandardOutput = "null";
      };
    };
  };

  # Timezone
  time.timeZone = "Asia/Kolkata";

  # ── Swap file ─────────────────────────────────────────────────────────
  # Waiting for nix Zswap implementation
  # https://github.com/NixOS/nixpkgs/pull/470366
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
      randomEncryption.enable = true; # False if hibernating
    }
  ];

  # ── Enables flakes ───────────────────────────────────────────────────────────
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # ── Enables networking ───────────────────────────────────────────────────────────
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  networking.firewall.enable = true;

  # ── Enables sound with pipewire ───────────────────────────────────────────────────────────
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # ── User ─────────────────────────────────────────────────────────────
  sops.secrets.zoro-password.neededForUsers = true;
  users.mutableUsers = false;

  users.users.${user} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.zoro-password.path;
    description = "ZORO";
    extraGroups = ["networkmanager" "wheel" "docker" "adbusers" "fuse" "video" "libvirtd"];
  };

  # ── Unfree packages ─────────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

  # ── Dynamically linked executable ─────────────────────────────────────────────────────────────
  programs.nix-ld.enable = true;

  # ── Enables flatpak ─────────────────────────────────────────────────────────────
  services.flatpak.enable = true;

  # ── XDG Portals ────────────────────────────────────
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk      # fallback for file pickers, etc.
      xdg-desktop-portal-gnome    # required for screencast on Niri
    ];

    config = {
      common = {
        default = [ "gtk" ];  # GTK as general fallback

        # Force ScreenCast to use the GNOME backend (Niri provides the Mutter interface it needs)
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];

        # Optional but helpful: force Screenshot too if you use portal-based screenshot tools
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      };
    };
  };

  # ── Enables ADB ─────────────────────────────────────────────────────────────
  programs.adb.enable = true;

  # ── Android and Iphone mounting ───────────────────────────────────────────────────────────
  # Android
  services.gvfs.enable = true;

  # Iphones
  services.usbmuxd.enable = true;

  # ── Thermal management for intel processors ─────────────────────────────────────────────────────────────
  services.thermald.enable = true;

  # ── Firmware updates ─────────────────────────────────────────────────────────────
  services.fwupd.enable = true;

  services.fprintd = {
      enable = true;
  };

  # ── Localsend ─────────────────────────────────────────────────────────────
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # ── Enables docker ─────────────────────────────────────────────────────────────
  virtualisation.docker.enable = true;

  # ── Virt-Manager setup ─────────────────────────────────────────────────────────────
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

  # ── Syncthing ─────────────────────────────────────────────────────────────
  # services.syncthing = {
  #   enable = true;
  #   user = "${user}";
  #   group = "users";
  #   openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
  #   dataDir = "/home/zoro/.syncthing";
  #   configDir = "/home/zoro/.config/syncthing";
  # };

  # ── Common packages ─────────────────────────────────────────────────────────────
  environment.systemPackages = [
    pkgs.neovim
    pkgs.wget
    pkgs.gitFull
    pkgs.zed-editor
    pkgs.alacritty
    pkgs.fuse
    pkgs.wev
    pkgs.bibata-cursors

    ### Android and IOS mounting ###
    pkgs.go-mtpfs
    pkgs.jmtpfs
    pkgs.libimobiledevice
    pkgs.ifuse
    ################################
  ];

  # ── Font packages ─────────────────────────────────────────────────────────────
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    fira-code-symbols
    nerd-fonts.iosevka
    nerd-fonts.hack
    inter-nerdfont
  ];

  # ── Nix cleanup ─────────────────────────────────────────────────────────────
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

  # ── Boot / Secure Boot (lanzaboote) ───────────────────────────────────
  # boot.loader.systemd-boot.enable = lib.mkForce false;
  # boot.lanzaboote = {
  #   enable = true;
  #   pkiBundle = "/etc/secureboot";
  # };
  # boot.loader.efi.canTouchEfiVariables = true;

  # ── Home Manager ───────────────────────────────────────────────────────
  # home-manager.users.${user} = import ./modules/profiles/desktop/home.nix;

  system.stateVersion = "25.11"; # Do not touch this
}
