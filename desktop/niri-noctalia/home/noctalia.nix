{ inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  ###########################################################################
  # Noctalia shell
  ###########################################################################

  programs.noctalia-shell.enable = true;
  # programs.noctalia-shell.systemd.enable = true;

  ###########################################################################
  # Udiskie (For Auto USB/Device mounts)
  ###########################################################################

  services.udiskie.enable = true;

}
