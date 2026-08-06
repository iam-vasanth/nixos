{...}: {
  imports = [
    # Hjem
    ./hjem/hjem.nix
    ./hjem/etc.nix

    # Packages
    ./packages/system.nix
    ./packages/flatpak.nix

    # Programs
    ./program/fastfetch.nix
    ./program/fish.nix
    ./programs/gaming.nix
    ./program/git.nix
    ./program/gpg-agent.nix
    ./program/gtk.nix
    ./program/kitty.nix
    ./program/lazyvim.nix
    ./program/mimeapps.nix
    ./program/mpv.nix
    ./program/noctalia.nix
    ./program/playerctld.nix
    ./program/ssh.nix
    ./program/starship.nix
    ./program/udiskie.nix
    ./program/zathura.nix
    ./program/zed.nix
    # ./programs/spicetify.nix # Too broke for a premium

    # WM
    ./wm/common.nix
    # ./wm/mango/mango.nix -  MangoWM has some dependency issues on upstream side as of right now.
    ./wm/niri/niri.nix
  ];
}
