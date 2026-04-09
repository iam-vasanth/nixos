{config, ...}: {
  ###########################################################################
  # Immich - Image server
  ###########################################################################

  services.immich = {
    enable = true;
    user = "immich";
    group = "services";
    host = "0.0.0.0";
    port = 2283;
    mediaLocation = "/data/immich";
  };

  ###########################################################################
  # Declarative permissions for Immich media directory
  ###########################################################################
  systemd.tmpfiles.rules = [
    "d ${config.services.immich.mediaLocation} 0770 ${config.services.immich.user} ${config.services.immich.group} -"

    # Ensure recursive ownership on rebuild
    "Z ${config.services.immich.mediaLocation} 0770 ${config.services.immich.user} ${config.services.immich.group} - -"
  ];

  ###########################################################################
  # Opens Firewall ports - Immich
  ###########################################################################

  networking.firewall.allowedTCPPorts = [2283];
}
