{
  pkgs,
  lib,
  inputs,
  user,
  hostname,
  ...
}: {
  # ── Boot (headless) ────────────────────────────────────────────────────
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; # adjust to your disk
    efiSupport = false; # set true + add efiSysMountPoint if UEFI
  };

  # ── Networking ─────────────────────────────────────────────────────────
  networking = {
    useDHCP = false;
    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.1.10"; # ← set your static IP
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.1.1";
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443];
    };
  };

  # ── SSH hardening ──────────────────────────────────────────────────────
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      AllowTcpForwarding = "yes";
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
    };
    # Only allow key-based auth
    extraConfig = ''
      AllowGroups wheel
    '';
  };

  # ── Fail2ban ───────────────────────────────────────────────────────────
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
    };
  };

  # ── Nginx (reverse proxy) ──────────────────────────────────────────────
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Example vhost — add your own below
    virtualHosts."example.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        proxyWebsockets = true;
      };
    };
  };

  # ── ACME / Let's Encrypt ───────────────────────────────────────────────
  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@example.com"; # ← your email
  };

  # ── Podman (rootless containers) ───────────────────────────────────────
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # "docker" aliased to podman
    defaultNetwork.settings.dns_enabled = true;
  };

  # ── Monitoring ─────────────────────────────────────────────────────────
  services.prometheus = {
    enable = true;
    port = 9090;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = ["systemd" "processes" "diskstats"];
        port = 9100;
      };
    };
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{targets = ["localhost:9100"];}];
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        domain = "grafana.example.com"; # ← adjust
      };
    };
  };

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
    nethogs
    nmap
    tcpdump
    lsof
    dnsutils
    openssl
    certbot
  ];

  # ── Automatic updates ──────────────────────────────────────────────────
  system.autoUpgrade = {
    enable = true;
    flake = "github:yourusername/nixos-config#server"; # ← adjust
    flags = ["--update-input" "nixpkgs"];
    dates = "04:00";
    randomizedDelaySec = "45min";
  };
}
