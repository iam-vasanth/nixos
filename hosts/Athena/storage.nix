{...}: {
  fileSystems."/mnt/BigPP" = {
    device = "/dev/disk/by-uuid/e0455b41-a087-4489-bba6-ea6750524880";
    fsType = "ext4";
    options = ["defaults" "noatime" "nofail" "x-gvfs-show"];
  };
}
