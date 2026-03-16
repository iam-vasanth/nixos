{
  pkgs,
  lib,
  inputs,
  user,
  host1,
  ...
}: {
  imports = [
  ];

  # ── Power profile ───────────────────────────────────────────────────────────
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # ── Enables Niri and GDM with LUKS autoLogin ───────────────────────────────────────────────────────────
  # programs.niri = {
  #   enable = true;
  #   package = pkgs.niri-unstable;
  # };

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "${user}";
    };
    gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };
  };

  # Disabled default polkit to use DMS's built-in polkit
  systemd.user.services.niri-flake-polkit.enable = false;

  # Keyring gets unlocked automatically with LUKS but this will render the noctalia fprintd un-usable
  services.gnome.gnome-keyring.enable = true;

  # ── Identity ───────────────────────────────────────────────────────────
  networking.hostName = "${host1}";

  # ── Host specific packages ─────────────────────────────────────────────────────────────
  environment.systemPackages = [
    pkgs.kitty
    pkgs.nautilus
    pkgs.wev
    pkgs.xwayland-satellite
  ];

  # # ── Disk layout (disko) ────────────────────────────────────────────────
  # # Run: sudo nix run 'nixpkgs#disko' -- --mode destroy,format,mount /etc/nixos/disko.nix
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
  #               extraArgs = [ "-L" "${host1}" ];
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
  home-manager.users.${user} = import ./desktop/niri-dms/home.nix;
}
