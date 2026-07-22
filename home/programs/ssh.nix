{config, ...}: {
  ###########################################################################
  # SSH configs
  ###########################################################################

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "github.com" = {
        identityFile = "~/.ssh/git_zoro";
        addKeysToAgent = "yes";
      };

      "gitlab.com" = {
        identityFile = "~/.ssh/git_zoro";
        addKeysToAgent = "yes";
      };

      # "vm-zoro" = {
      #   hostname = "192.168.122.130";
      #   user = "zoro";
      #   identityFile = config.sops.secrets."private_keys/zoro_key".path;
      #   identitiesOnly = true;
      # };

      # "hades" = {
      #   hostname = "100.117.30.13";
      #   user = "zoro";
      #   identityFile = config.sops.secrets."private_keys/zoro_key".path;
      #   identitiesOnly = true;
      # };
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}
