{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    #listenAddress = "0.0.0.0";
    #port = 8086;
    user = "jellyfin";
    group = "services";
    dataDir = "/data/media";
  };

  systemd.tmpfiles.rules = [
    "d ${config.services.jellyfin.dataDir} 0770 ${config.services.jellyfin.user} ${config.services.jellyfin.group} -"

    # Ensure recursive ownership on rebuild
    "Z ${config.services.jellyfin.dataDir} 0770 ${config.services.jellyfin.user} ${config.services.jellyfin.group} - -"
  ];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
