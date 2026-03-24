{ ... }:

{

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    mediaLocation = "/var/lib/immich";
  };
  networking.firewall.allowedTCPPorts = [ 2283 ];
}
