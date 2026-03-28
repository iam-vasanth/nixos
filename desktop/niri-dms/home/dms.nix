{
  inputs,
  pkgs,
  unstable,
  ...
}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  ###########################################################################
  # DMS
  ###########################################################################

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    dgop.package = unstable.dgop;
    enableDynamicTheming = true;
    enableClipboardPaste = true;
    niri = {
      enableSpawn = true;
    };
  };

  ###########################################################################
  # Udiskie (For Auto USB/Device mounts)
  ###########################################################################

  services.udiskie.enable = true;
}
