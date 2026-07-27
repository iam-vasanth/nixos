{ pkgs, ... }: {
  ###########################################################################
  # GPG agent (with SSH support, replaces home-manager's services.gpg-agent)
  ###########################################################################

  environment.systemPackages = [ pkgs.gnupg pkgs.pinentry-gtk2 ];

  hjf.".gnupg/gpg-agent.conf" = {
    text = ''
      enable-ssh-support
      default-cache-ttl 600
      max-cache-ttl 7200
      pinentry-program ${pkgs.pinentry-gtk2}/bin/pinentry-gtk-2
    '';
    permissions = "600";
  };

  systemd.user.services.gpg-agent = {
    description = "GnuPG cryptographic agent and passphrase cache";
    unitConfig.Documentation = "man:gpg-agent(1)";

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.gnupg}/bin/gpg-agent --supervised";
      ExecReload = "${pkgs.gnupg}/bin/gpgconf --reload gpg-agent";
      Restart = "on-failure";
    };
  };

  systemd.user.sockets.gpg-agent-ssh = {
    description = "GnuPG cryptographic agent (ssh-agent emulation)";
    listenStreams = [ "%t/gnupg/S.gpg-agent.ssh" ];
    socketConfig = {
      FileDescriptorName = "ssh";
      Service = "gpg-agent.service";
      SocketMode = "0600";
      DirectoryMode = "0700";
    };
    wantedBy = [ "sockets.target" ];
  };

  # Point SSH_AUTH_SOCK at gpg-agent's ssh-emulation socket
  environment.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh";
}
