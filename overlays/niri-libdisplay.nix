final: prev: {
  niri = prev.niri.override {
    libdisplay-info = prev.libdisplay-info.overrideAttrs (_: {
      version = "0.3.0";
      src = final.fetchFromGitLab {
        domain = "gitlab.freedesktop.org";
        owner = "emersion";
        repo = "libdisplay-info";
        rev = "0.3.0";
        hash = "sha256-nXf2KGovNKvcchlHlzKBkAOeySMJXgxMpbi5z9gLrdc=";
      };
    });
  };
}
