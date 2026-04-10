{
  config,
  user,
  hostname,
  pkgs,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./nixos/include.nix
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
  # Hostname
  ###########################################################################

  networking.hostName = "${hostname}";

  ###########################################################################
  # User
  ###########################################################################

  # sops.secrets.zoro-password.neededForUsers = true;
  # users.mutableUsers = false;

  users.users.${user} = {
    isNormalUser = true;
    # hashedPasswordFile = config.sops.secrets.zoro-password.path;
    description = "ZORO";
    extraGroups = ["networkmanager" "wheel" "docker" "fuse" "libvirtd"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM8gMfrAx7QGMkIHLJhe5NI/PbGiTzomS4GgWoYpI/Ip vk.vasanth.r@gmail.com"
    ];
  };

  users.groups.services = {
    members = [ "${user}" ];
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
    useDHCP = false;
    firewall.enable = false;
  };

  ###########################################################################
  # Minimal Gnome DE for fallback
  ###########################################################################

  # services.xserver.enable = true;
  # services.desktopManager.gnome.enable = true;
  # services.displayManager = {
  #   autoLogin = {
  #     enable = true;
  #     user = "${user}";
  #   };
  #   gdm = {
  #     enable = true;
  #     wayland = true;
  #     autoSuspend = false;
  #   };
  # };

  # environment.gnome.excludePackages = (with pkgs; [
  #   simple-scan
  #   gnome-photos
  #   gnome-tour
  #   cheese
  #   gnome-music
  #   epiphany
  #   geary
  #   gnome-characters
  #   tali
  #   iagno
  #   hitori
  #   atomix
  #   yelp
  #   gnome-contacts
  #   gnome-initial-setup
  #   baobab
  #   gnome-text-editor
  #   gnome-music
  #   gnome-software
  # ]);

  ###########################################################################
  # OpenSSH
  ###########################################################################

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      AllowTcpForwarding = "no";
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
      AllowGroups = ["wheel"];
      LogLevel = "VERBOSE";
    };
  };

  ###########################################################################
  # Fail2ban
  ###########################################################################

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
    };
    # For whitelisting trusted IP's
    # ignoreip = "192.168.1.0/24 10.0.0.0/8";
  };

  ###########################################################################
  # Systemd-resolved for DNS resolution
  ###########################################################################

  services.resolved.enable = true;

  ###########################################################################
  # Nginx ( Reverse proxy )
  ###########################################################################

  # Disabled because im using Nginx proxy manager (Docker Container)
  # services.nginx = {
  #   enable = true;
  #   recommendedGzipSettings = true;
  #   recommendedOptimisation = true;
  #   recommendedProxySettings = true;
  #   recommendedTlsSettings = true;

  #   # Example vhost
  #   virtualHosts."example.com" = {
  #     enableACME = true;
  #     forceSSL = true;
  #     locations."/" = {
  #       proxyPass = "http://127.0.0.1:8080";
  #       proxyWebsockets = true;
  #     };
  #   };
  # };

  ###########################################################################
  # Podman (rootless containers)
  ###########################################################################

  virtualisation.docker = {
    enable = true;
    # dockerCompat = true;
    # defaultNetwork.settings.dns_enabled = true;
  };

  ###########################################################################
  # Prometheus ( Using glance for minimal setup now )
  ###########################################################################

  # services.prometheus = {
  #   enable = true;
  #   port = 9090;
  #   exporters = {
  #     node = {
  #       enable = true;
  #       enabledCollectors = ["systemd" "processes" "diskstats"];
  #       port = 9100;
  #     };
  #   };
  #   scrapeConfigs = [
  #     {
  #       job_name = "node";
  #       static_configs = [{targets = ["localhost:9100"];}];
  #     }
  #   ];
  # };

  ###########################################################################
  # Grafana ( Using glance for minimal setup now )
  ###########################################################################

  # services.grafana = {
  #   enable = true;
  #   settings = {
  #     server = {
  #       http_addr = "127.0.0.1";
  #       http_port = 3000;
  #       domain = "grafana.example.com"; # ← adjust
  #     };
  #   };
  # };

  ###########################################################################
  # Tailscale
  ###########################################################################

  services.tailscale.enable = true;

  ###########################################################################
  # Journalctl logs ( Extra config )
  ###########################################################################

  services.journald.extraConfig = ''
    SystemMaxUse=2G
    MaxRetentionSec=1month
  '';

  ###########################################################################
  # Host specific common packages
  ###########################################################################

  environment.systemPackages = with pkgs; [
    podman-compose
    ncdu
    iotop
    btop
    nethogs
    nmap
    tcpdump
    lsof
    dnsutils
    openssl
    certbot
    git
  ];

  ###########################################################################
  # Home Manager
  ###########################################################################

  home-manager.users.${user} = import ./home.nix;

  ###########################################################################
  # State version - Do not touch this
  ###########################################################################

  system.stateVersion = "25.11";
}
