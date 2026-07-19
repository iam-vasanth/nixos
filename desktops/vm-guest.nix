{lib, config, ...}:
lib.mkIf config.mycustom.vm.enable {

  ###########################################################################
  # SSH for VM guest
  ###########################################################################

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  ###########################################################################
  # VM guest tools
  ###########################################################################

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  ###########################################################################
  # Filesystem mount
  ###########################################################################

  fileSystems."/home/zoro/nixos" = {
    device = "nixos";
    fsType = "virtiofs";
    options = ["defaults" "nofail"];
  };
}
