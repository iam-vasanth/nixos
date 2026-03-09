{ ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      schema = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        type = "file";
        source = "~/.config/fastfetch/ascii.txt";
        padding = {
          top = 2;
          left = 2;
          right = 2;
        };
      };
      display = {
        separator = "";
      };
      modules = [
        {
          type = "custom";
          key = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
        }
        {
          type = "title";
          outputColor = "white";
          format = "{user-name} {home-dir}";
          key = " PRFIL  ";
        }
        {
          type = "custom";
          key = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
        }
        {
          type = "cpu";
          outputColor = "white";
          format = "{name} ({cores-logical}) {freq-max}";
          key = " PROCS  ";
        }
        {
          type = "gpu";
          outputColor = "white";
          format = "{vendor} {name} - {type}";
          key = " GRAPH 󰊗 ";
        }
        {
          type = "memory";
          outputColor = "white";
          format = "";
          key = " MEMRY  ";
        }
        {
          type = "custom";
          key = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
        }
        {
          type = "os";
          outputColor = "white";
          format = "{pretty-name}";
          key = " OPSYS 󰒓 ";
        }
        {
          type = "custom";
          key = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
        }
        {
          type = "display";
          outputColor = "white";
          format = "{inch}\" {refresh-rate}Hz {width}x{height} {name}";
          key = " DISPY 󰍹 ";
        }
        {
          type = "custom";
          key = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
        }
        {
          type = "shell";
          outputColor = "white";
          format = "{process-name}";
          key = " SHELL  ";
        }
        {
          type = "terminal";
          outputColor = "white";
          format = "{pretty-name}";
          key = " TRMAL  ";
        }
        {
          type = "terminalfont";
          outputColor = "white";
          format = "{name}";
          key = " TRFNT  ";
        }
        {
          type = "custom";
          key = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
        }
        {
          type = "disk";
          outputColor = "white";
          format = "";
          key = " DISKS  ";
        }
        {
          type = "custom";
          key = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
        }
      ];
    };
  };
}
