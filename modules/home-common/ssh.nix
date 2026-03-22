{ config, user, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        identityFile = config.sops.secrets."private_keys/zoro_key".path;
        addKeysToAgent = "yes";
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };

  services.ssh-agent = {
    enable = true;
    enableFishIntegration = true;
  };
}
