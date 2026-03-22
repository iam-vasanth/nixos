{ inputs, ... }:

let
  secretspath = builtins.toString inputs.sops-secrets;
in

{
  home.file.".ssh/zoro_key.pub".source = "${secretspath}/public_keys/zoro_key.pub";
}
