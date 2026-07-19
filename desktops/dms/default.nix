{
  inputs,
  hostname,
  user,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos/niri-dms.nix
  ];
  home-manager.users.${user} = {
    imports = [
      ./home.nix

      ../../modules/home/common/etc.nix
      ../../modules/home/common/mimeapps.nix
      ../../modules/home/common/niri.nix
      ../../modules/home/common/pkgs.nix

      ../../modules/home/programs/fastfetch.nix
      ../../modules/home/programs/fish.nix
      ../../modules/home/programs/fastfetch.nix
      ../../modules/home/programs/git.nix
      ../../modules/home/programs/kitty.nix
      ../../modules/home/programs/ssh.nix
      ../../modules/home/programs/starship.nix
      ../../modules/home/programs/zed.nix
    ];

    ###########################################################################
    # Home state version - Do not touch this
    ###########################################################################

    home.stateVersion = "26.05";
  };
}
