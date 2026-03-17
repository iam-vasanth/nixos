{ inputs, unstable, ... }:

{

  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    dgop.package = unstable.dgop;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableClipboardPaste = true;
    niri = {
      enableSpawn = true;
    };
  };
}
