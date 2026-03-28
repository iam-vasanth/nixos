{ pkgs, ... }:

{
  services.glance = {
    enable = true;
    settings = {
      server = {
        host = "0.0.0.0";
        port = 8080;
      };
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                { type = "clock"; timezone = "Asia/Kolkata"; hour-format = "24h"; }
                { type = "calendar"; }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "bookmarks";
                  groups = [
                    {
                      title = "Services";
                      links = [
                        { title = "Immich"; url = "http://192.168.122.130:2283"; icon = "sh:immich"; }
                        { title = "Nginx Proxy Manager"; url = "http://192.168.122.130:81"; icon = "sh:nginx-proxy-manager"; }
                      ];
                    }
                  ];
                }
                {
                  type = "hacker-news";
                  limit = 10;
                  collapse-after = 5;
                }
              ];
            }
            {
              size = "small";
              widgets = [
                { type = "server-stats"; }
              ];
            }
          ];
        }
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 2283 80 443 81 8080 ];
}
