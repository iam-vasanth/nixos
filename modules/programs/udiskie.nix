{ pkgs, ... }: {
  ###########################################################################
  # Udiskie - automounts removable media
  ###########################################################################

  environment.systemPackages = [ pkgs.udiskie ];

  systemd.user.services.udiskie = {
    description = "Automounter for removable media";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.udiskie}/bin/udiskie --tray=never --no-notify";
      Restart = "on-failure";
    };
  };
}
