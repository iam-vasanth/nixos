{ host, user, pkgs, lib, ... }:

{

  # Zen kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel params
  boot.consoleLogLevel = 0;
  boot.initrd.systemd.enable = true;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "vt.global_cursor_default=0"
  ];

  # Silences systemd logs
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    settings = {
      Manager = {
        ShowStatus = "no";
        DefaultStandardOutput = "null";
      };
    };
  };
}
