{
  config,
  pkgs,
  ...
}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers."nginx-proxy-manager" = {
      image = "jc21/nginx-proxy-manager:latest";
      autoStart = true;
      ports = [
        "8081:80"
        "8443:443"
        "81:81"
      ];
      volumes = [
        "/var/lib/nginx-proxy-manager/data:/data"
        "/var/lib/nginx-proxy-manager/letsencrypt:/etc/letsencrypt"
      ];
      environment = {
        TZ = "Asia/Kolkata";
        # Optional: Disable IPv6 if needed
        # DISABLE_IPV6 = "true";
      };
    };
  };

  # Permissions for the directories
  systemd.tmpfiles.rules = [
    "d /var/lib/nginx-proxy-manager/data 0755 root root -"
    "d /var/lib/nginx-proxy-manager/letsencrypt 0755 root root -"
  ];

  networking.firewall.allowedTCPPorts = [8081 8443 81];
}
