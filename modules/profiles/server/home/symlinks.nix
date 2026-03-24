{ ... }:

{
  home.file.".ssh/zoro_key.pub".source = ../../../../.secrets/public_keys/zoro_key.pub;
  home.file."/var/lib/glance/glance.yml".source = ../configs/glance.yaml;
}
