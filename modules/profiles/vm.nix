{
  pkgs,
  lib,
  inputs,
  user,
  hostname,
  ...
}: {
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  fileSystems."/home/zoro/nixos" = {
    device = "nixos";
    fsType = "virtiofs";
    options = ["defaults" "nofail"];
  };
}
