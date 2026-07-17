{
  inputs,
  hostname,
  user,
  pkgs,
  ...
}: {
  imports = [
    ./configs/default.nix
    ./configs/home.nix

    ./home/*

  ];
}
