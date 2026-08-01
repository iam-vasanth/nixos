{pkgs, impure, ...}: {
  hjf = {
    ".config/mpv/shaders".source = "${pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders";
    ".config/mpv/mpv.conf".source = impure.dots + "/mpv/mpv.conf";
    ".config/mpv/input.conf".source = impure.dots + "/mpv/input.conf";
  };
}
