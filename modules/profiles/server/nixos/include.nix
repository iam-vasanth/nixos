{...}: {
  imports = [
    ./immich.nix
    ./glance.nix
    ./nginx.nix
    ./portainer.nix
    # ./sops.nix
    ./cloudflared.nix
    ./jellyfin.nix
  ];
}
