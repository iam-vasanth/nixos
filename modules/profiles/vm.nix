{
  ...
}: {
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  fileSystems."/home/zoro/nix" = {
    device = "nix";
    fsType = "virtiofs";
    options = ["defaults" "nofail"];
  };
}
