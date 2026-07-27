{ ... }:
{
  imports = [
    # Hjem
    ./hjem/hjem.nix
    ./hjem/etc.nix

    # Packages
    ./packages/system.nix
    ./packages/flatpak.nix

    # Programs
    ./programs/fastfetch.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/gpg-agent.nix
    ./programs/kitty.nix
    ./programs/mimeapps.nix
    ./programs/mpv.nix
    ./programs/noctalia.nix
    ./programs/playerctld.nix
    ./programs/ssh.nix
    ./programs/starship.nix
    ./programs/udiskie.nix
    ./programs/zathura.nix
    # ./programs/spicetify.nix # Too broke for a premium

    # WM
    ./wm/common.nix
    ./wm/niri/niri.nix
  ];
}
