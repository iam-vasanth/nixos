# lib/mk-module-registry.nix

{ lib }:

let
  inherit (builtins)
    readFile
    stringLength
    pathExists
    removeAttrs
    attrNames
    match
    replaceStrings
    foldl';

  inherit (lib)
    recursiveUpdate
    setAttrByPath
    removePrefix;
in

{
  root,
  files,
  extraArgs ? {},
}:

foldl'
  (registry: file:
    let
      # Skip empty files just in case
      _ = assert pathExists file;
      _ = assert stringLength (readFile file) > 0;

      rel =
        removePrefix
          (toString root + "/")
          (toString file);

      # wm/niri.nix -> wm/niri
      name =
        replaceStrings
          [ ".nix" "/default" ]
          [ "" "" ]
          rel;

      path =
        builtins.filter
          (x: x != "")
          (lib.splitString "/" name);

    in
      recursiveUpdate registry (
        setAttrByPath path (
          import file extraArgs
        )
      )
  )
  {}
  files
