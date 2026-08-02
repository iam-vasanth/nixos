{
  pkgs,
  unstable,
  ...
}: {

  ###########################################################################
  # A local cache (if host has it)
  ###########################################################################

  nix.settings = {
    extra-substituters = [ "file:///home/zoro/nixos/.nix-cache" ];
    extra-trusted-substituters = [ "file:///home/zoro/nixos/.nix-cache" ];
    require-sigs = false;
  };

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

  ###########################################################################
  # Optional VM only packages
  ###########################################################################

  environment.systemPackages = [pkgs.firefox];
}
