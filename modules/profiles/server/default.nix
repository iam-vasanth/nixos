{
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

  # ── Kernal ───────────────────────────────────────────────────────────
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ── Networking ─────────────────────────────────────────────────────────
  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
    useDHCP = false;
    # interfaces.eth0.ipv4.addresses = [
    #   {
    #     address = "192.168.1.10";
    #     prefixLength = 24;
    #   }
    # ];
    # defaultGateway = "192.168.1.1";
    # nameservers = [
    #     "8.8.8.8"
    #     "1.1.1.1"
    #     "9.9.9.9"
    #   ];
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443];
    };
  };

  programs.firefox.enable = true;

  time.timeZone = "Asia/Kolkata";

  # ── SSH hardening ──────────────────────────────────────────────────────
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
    };
    # Only allow key-based auth
    extraConfig = ''
      AllowGroups wheel
    '';
  };

  # ── Fail2ban ───────────────────────────────────────────────────────────
  # services.fail2ban = {
  #   enable = true;
  #   maxretry = 5;
  #   bantime = "1h";
  #   bantime-increment = {
  #     enable = true;
  #     multipliers = "1 2 4 8 16 32 64";
  #   };
  #   # For whitelisting trusted IP's
  #   # ignoreip = "192.168.1.0/24 10.0.0.0/8";
  # };

  # ── Enables flakes ───────────────────────────────────────────────────────────
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # ── User ─────────────────────────────────────────────────────────────
  users.users.${user} = {
    isNormalUser = true;
    description = "ZORO";
    extraGroups = ["networkmanager" "wheel" "docker" "podman" "fuse" "video" "libvirtd"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM8gMfrAx7QGMkIHLJhe5NI/PbGiTzomS4GgWoYpI/Ip vk.vasanth.r@gmail.com"
    ];
    # openssh.authorizedKeys.keys = [
    #   (builtins.readFile ../../../.secrets/public_keys/zoro_key.pub)
    # ];
  };


  # # ───────────────────────────────────────────────────────────
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

  # ── Nginx (reverse proxy) ──────────────────────────────────────────────
  # Disabled because im usinf Nginx proxy manager (Docker Container)
  # services.nginx = {
  #   enable = true;
  #   recommendedGzipSettings = true;
  #   recommendedOptimisation = true;
  #   recommendedProxySettings = true;
  #   recommendedTlsSettings = true;

  #   # Example vhost — add your own below
  #   virtualHosts."example.com" = {
  #     enableACME = true;
  #     forceSSL = true;
  #     locations."/" = {
  #       proxyPass = "http://127.0.0.1:8080";
  #       proxyWebsockets = true;
  #     };
  #   };
  # };

  # ── ACME / Let's Encrypt ───────────────────────────────────────────────
  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "admin@example.com"; # ← your email
  # };

  # ── Podman (rootless containers) ───────────────────────────────────────
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # ── Monitoring ─────────────────────────────────────────────────────────
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

  # ── Logs ───────────────────────────────────────────────────────────────
  services.journald.extraConfig = ''
    SystemMaxUse=2G
    MaxRetentionSec=1month
  '';

  # ── Server packages ────────────────────────────────────────────────────
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

  # ── Automatic updates ──────────────────────────────────────────────────
  # system.autoUpgrade = {
  #   enable = true;
  #   flake = "github:yourusername/nixos-config#server"; # ← adjust
  #   flags = ["--update-input" "nixpkgs"];
  #   dates = "04:00";
  #   randomizedDelaySec = "45min";
  # };

  home-manager.users.${user} = import ./home.nix;

  system.stateVersion = "25.11"; # Do not touch this
}
