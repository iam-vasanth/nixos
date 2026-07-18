{...}: {

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

  fileSystems."/home/zoro/nix" = {
    device = "nix";
    fsType = "virtiofs";
    options = ["defaults" "nofail"];
  };
}
