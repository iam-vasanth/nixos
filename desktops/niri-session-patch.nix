{
  lib,
  pkgs,
  unstable,
  ...
}: {
  ###########################################################################
  # Patches niri-session to silence the "Calling import-environment without a list of variable names is deprecated."
  # https://github.com/niri-wm/niri/issues/254
  ###########################################################################
  programs.niri.package = lib.mkForce (
    (pkgs.symlinkJoin {
      name = "niri-quiet-session";
      paths = [unstable.niri];

      postBuild = ''
        rm -f "$out/bin/niri-session"
        substitute "${unstable.niri}/bin/niri-session" "$out/bin/niri-session" \
          --replace-quiet 'systemctl --user import-environment' \
                           'systemctl --user import-environment >/dev/null 2>&1' \
          --replace-quiet 'dbus-update-activation-environment --all' \
                           'dbus-update-activation-environment --all >/dev/null 2>&1'
        chmod +x "$out/bin/niri-session"
      '';
    })
    // {
      inherit (unstable.niri) cargoBuildNoDefaultFeatures cargoBuildFeatures providedSessions;
    }
  );
}
