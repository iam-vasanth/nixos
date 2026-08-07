{...}: {
  fileSystems."/mnt/BigPP" = {
    device = "/dev/disk/by-uuid/6C3A36033A35CABA";
    fsType = "ext4";
    options = ["defaults" "noatime" "nofail"];
  };
}
