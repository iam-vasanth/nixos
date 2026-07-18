{
  inputs,
  hostname,
  user,
  pkgs,
  ...
}: {
  imports = [
    ./configs/default.nix
  ];
  home-manager.users.${user} = {
    imports = [
      ./configs/home.nix

      ../../home/common/etc.nix
      ../../home/common/mimeapps.nix
      ../../home/common/niri.nix
      ../../home/common/pkgs.nix

      ../../home/programs/fastfetch.nix
      ../../home/programs/fish.nix
      ../../home/programs/fastfetch.nix
      ../../home/programs/git.nix
      ../../home/programs/kitty.nix
      ../../home/programs/ssh.nix
      ../../home/programs/starship.nix
      ../../home/programs/zed.nix
    ];

    ###########################################################################
    # Home state version - Do not touch this
    ###########################################################################

    home.stateVersion = "26.05";
  };
}
