{pkgs, ...}: {
  ###########################################################################
  # playerctld - MPRIS daemon
  ###########################################################################

  environment.systemPackages = [pkgs.playerctl];

  systemd.user.services.playerctld = {
    description = "MPRIS daemon for playerctl";
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];

    serviceConfig = {
      Type = "dbus";
      BusName = "org.mpris.MediaPlayer2.playerctld";
      ExecStart = "${pkgs.playerctl}/bin/playerctld";
      Restart = "on-failure";
    };
  };
}
