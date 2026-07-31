{...}: {
  ###########################################################################
  # Flatpaks
  ###########################################################################

  services.flatpak = {
    enable = true;

    overrides.settings = {
      "app.zen_browser.zen".Context = ["filesystems=xdg-download;"];
    };

    packages = [
      {
        appId = "app.zen_browser.zen";
        origin = "flathub";
      }
      {
        appId = "de.haeckerfelix.Fragments";
        origin = "flathub";
      }
      {
        appId = "com.github.tchx84.Flatseal";
        origin = "flathub";
      }
      {
        appId = "io.gitlab.adhami3310.Impression";
        origin = "flathub";
      }
      {
        appId = "com.ranfdev.DistroShelf";
        origin = "flathub";
      }
      {
        appId = "io.github.flattool.Warehouse";
        origin = "flathub";
      }
      {
        appId = "com.usebottles.bottles";
        origin = "flathub";
      }
      {
        appId = "com.rustdesk.RustDesk";
        origin = "flathub";
      }
      {
        appId = "io.github.anil_e.Codd";
        origin = "flathub";
      }
      {
        appId = "com.github.marhkb.Pods";
        origin = "flathub";
      }
      {
        appId = "com.protonvpn.www";
        origin = "flathub";
      }
      {
        appId = "com.github.IsmaelMartinez.teams_for_linux";
        origin = "flathub";
      }
      {
        appId = "dev.skynomads.Seabird";
        origin = "flathub";
      }
      {
        appId = "org.telegram.desktop";
        origin = "flathub";
      }
      {
        appId = "dev.vencord.Vesktop";
        origin = "flathub";
      }
      {
        appId = "org.pvermeer.WebAppHub";
        origin = "flathub";
      }
    ];

    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
