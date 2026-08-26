{ config, pkgs, unstable, ... }:

{

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  environment.systemPackages = [
    (pkgs.heroic.override {
      extraPkgs = pkgs': with pkgs'; [
        gamescope
        gamemode
      ];
    })
  ];

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
}
