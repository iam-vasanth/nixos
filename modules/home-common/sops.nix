{ config, ... }:

{
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../.secrets/secrets.yaml;
    validateSopsFiles = false;
    secrets = {
      "private_keys/zoro_key" ={
        path = "${config.home.homeDirectory}/.ssh/zoro_key";
        mode = "0600";
      };
    };
  };
}
