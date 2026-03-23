{ config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        identityFile = config.sops.secrets."private_keys/zoro_key".path;
        addKeysToAgent = "yes";
      };
      "gitlab.com" = {
        identityFile = config.sops.secrets."private_keys/zoro_key".path;
        addKeysToAgent = "yes";
      };
      "vm-zoro" = {
        hostname = "192.168.122.130";
        user = "zoro";
        identityFile = config.sops.secrets."private_keys/zoro_key".path;
        identitiesOnly = true;
      };
    };
    # extraConfig = ''
    #   AddKeysToAgent yes
    # '';
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
