{ host, user, pkgs, lib, ... }:

{

  # Hostname
  networking.hostName = "${host}";

  # User account
  users.users.${user} = {
    isNormalUser = true;
    description = "ZORO";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" "fuse" "video" ];
  };

  # Enables flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enables networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  networking.firewall.enable = true;

  # Enables sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
