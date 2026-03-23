{ ... }:

{

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    mediaLocation = /home/zoro/Pictures/immich;
    networking.firewall.allowedTCPPorts = [ 2283 ];
  };
}
