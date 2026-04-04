{
  lib,
  inputs,
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
  # Adds DMS zen theme to the zen default profile folder
  ###########################################################################

  home.activation.zenChrome = lib.hm.dag.entryAfter ["writeBoundary"] ''
    for PROFILE_DIR in \
        "$(find ~/.zen -maxdepth 1 -type d -name "*.Default Profile" 2>/dev/null | head -n 1)" \
        "$(find "$HOME/.config/zen" -maxdepth 1 -type d -name "*Default (release)" 2>/dev/null | head -n 1)" \
        "$(find "$HOME/.var/app/app.zen_browser.zen/.zen" -maxdepth 1 -type d -name "*Default (release)" 2>/dev/null | head -n 1)"
    do
        [ -z "$PROFILE_DIR" ] && continue
        mkdir -p "$PROFILE_DIR/chrome"
        ln -sf "$HOME/.config/DankMaterialShell/zen.css" "$PROFILE_DIR/chrome/userChrome.css"
    done
  '';

  ###########################################################################
  # Udiskie (For Auto USB/Device mounts)
  ###########################################################################

  services.udiskie.enable = true;
}
