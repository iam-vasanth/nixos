{
  pkgs,
  lib,
  inputs,
  user,
  host2,
  ...
}: {
  imports = [
    ./hosts/default.nix
  ];

  # ── Enables Cosmic ───────────────────────────────────────────────────────────
  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.cosmic-greeter.enable = true;

  # ── Identity ───────────────────────────────────────────────────────────
  networking.hostName = "${host2}";

  # ── Host specific packages ─────────────────────────────────────────────────────────────
  environment.systemPackages = [
    pkgs.kitty
    pkgs.wev
  ];

  # # ── Disk layout (disko) ────────────────────────────────────────────────
  # # Run: sudo nix run 'nixpkgs#disko' -- --mode destroy,format,mount /etc/nixos/disko.nix
  # # (or integrate in your flake / configuration.nix)
  # disko.devices = {
  #   disk.nvme0 = {
  #     type = "disk";
  #     device = "/dev/nvme0n1"; # ← always verify with lsblk or ls /dev/disk/by-id/
  #     content = {
  #       type = "gpt";
  #       partitions = {
  #         esp = {
  #           size = "1G";
  #           type = "EF00";
  #           content = {
  #             type = "filesystem";
  #             format = "vfat";
  #             mountpoint = "/boot";
  #           };
  #         };
  #         luks = {
  #           size = "100%";
  #           content = {
  #             type = "luks";
  #             name = "cryptroot";
  #             settings.allowDiscards = true;  # enables TRIM on SSD
  #             # You can add more settings here if needed, e.g.:
  #             # extraOpenArgs = [ "--perf-options" "noop" ]; etc.

  #             content = {
  #               type = "filesystem";
  #               format = "ext4";
  #               mountpoint = "/";
  #               # Optional: add label and extra mount options
  #               extraArgs = [ "-L" "${host2}" ];
  #               mountOptions = [
  #                 "noatime"          # reduces unnecessary writes → better SSD life
  #                 "discard"          # enables periodic TRIM (complements allowDiscards)
  #                 # "errors=remount-ro"  # optional safety
  #               ];
  #             };
  #           };
  #         };
  #       };
  #     };
  #   };
  # };

  # ── Home Manager ───────────────────────────────────────────────────────
  home-manager.users.${user} = import ../../home/default.nix;
}
