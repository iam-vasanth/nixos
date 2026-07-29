{
  lib,
  config,
  pkgs,
  unstable,
  ...
}: {
  ###########################################################################
  # Patches niri-session to silence the "Calling import-environment without a list of variable names is deprecated."
  # https://github.com/niri-wm/niri/issues/254
  ###########################################################################

  config = lib.mkIf config.wm.niri.enable {
    modifications = final: prev: {
      # FIXME Temporary until nixos-unstable includes nixpkgs c088236, which pins Niri
      # to the newest libdisplay-info version supported by libdisplay-info-rs.
      niri = prev.niri.override {
        libdisplay-info = prev.libdisplay-info.overrideAttrs (_oldAttrs: rec {
          version = "0.3.0";
          src = final.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "emersion";
            repo = "libdisplay-info";
            rev = version;
            hash = "sha256-nXf2KGovNKvcchlHlzKBkAOeySMJXgxMpbi5z9gLrdc=";
          };
        });
      };
    };

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
  };
}
