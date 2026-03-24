{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.glance ];

  systemd.services.glance = {
    description = "Glance Dashboard";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.glance}/bin/glance --config /var/lib/glance/glance.yml";
      Restart = "always";
      User = "glance";
      Group = "glance";
      StateDirectory = "glance";
      WorkingDirectory = "/var/lib/glance";
      DynamicUser = true;
    };
  };

  # Open the port in firewall
  networking.firewall.allowedTCPPorts = [ 8080 ];
}
