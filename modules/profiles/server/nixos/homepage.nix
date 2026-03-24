{ pkgs, ... }:

{
  services.glance = {
    enable = true;
    settings = ../configs/glance.yml;
  };

  # Open the port in firewall
  networking.firewall.allowedTCPPorts = [ 8080 ];
}
