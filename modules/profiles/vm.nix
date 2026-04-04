{...}: {
  ###########################################################################
  # VM guest tools
  ###########################################################################

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  ###########################################################################
  # Filesystem mount
  ###########################################################################

  fileSystems."/home/zoro/nix" = {
    device = "nix";
    fsType = "virtiofs";
    options = ["defaults" "nofail"];
  };
}
