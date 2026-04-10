{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    listenAddress = "0.0.0.0";
    port = 8086;
    user = "jellyfin";
    group = "services";
    dataDir = "/data/media";
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
