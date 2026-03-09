final: prev:

let
  # Optional: helper to make patches more readable
  applyPatches = pkg: patches: pkg.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ patches;
    # You can also do this if you want to force recompile:
    # pname = "${old.pname}-patched";
    # version = "${old.version}+patches";
  });

  # You can also use final.fetchpatch / final.fetchpatch.url if you prefer
  # to keep patches in the nix store without committing them.
in
{
  patched = {
    # ───────────────────────────────────────────────
    # firefox = applyPatches prev.firefox [
      # ./../patches/firefox/0001-dont-phone-home.patch
      # ./../patches/firefox/0002-smaller-titlebar.patch
      # or: (final.fetchpatch { url = "..."; hash = "sha256-..."; })
    # ];

    # mpv with one small patch
    # mpv = applyPatches prev.mpv [
    #   ./../patches/mpv/hwdec-vdpau-fix.patch
    # ];

    # Example: completely custom src + patches
    # vscode = prev.vscode.overrideAttrs (old: {
    #   src = final.fetchurl { ... };
    #   patches = (old.patches or []) ++ [ ... ];
    # });

    # chromium = prev.chromium.override { ... };

    # Add more here …
  };
}
