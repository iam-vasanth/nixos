{
  description = "NixOS flake - Athena.";

  # Noctalia cachix
  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    qtengine = {
      url = "github:kossLAN/qtengine";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    niri.url = "github:sodiboo/niri-flake";

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    sops-nix.url = "github:mic92/sops-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    disko.url = "github:nix-community/disko";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    niri,
    mangowm,
    nixos-hardware,
    sops-nix,
    nix-flatpak,
    disko,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "zoro";

    paths = {
      dots = ./dots;
      devsh = ./devshells;
    };

    pkgs = nixpkgs.legacyPackages.${system};
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    mkHost = {hostname, hosts, hardwareModules ? []}: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs hostname user unstable paths;};

      modules = [
        ./hosts/default.nix
        ./hosts/${hostname}/default.nix
        ./hosts/${hostname}/disko.nix
        ./hosts/${hostname}/hardware-configuration.nix
        ./modules/default.nix

        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        niri.nixosModules.niri
        mangowm.nixosModules.mango
        inputs.hjem.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak

      ] ++ hardwareModules;
    };

  in {
    formatter.${system} = pkgs.alejandra;

    # # Dev shells
    # devShells.${system} = {
    #   default  = import ./devshells/default.nix  { inherit pkgs unstable; };
    #   backend  = import ./devshells/backend.nix  { inherit pkgs unstable; };
    #   frontend = import ./devshells/frontend.nix { inherit pkgs unstable; };
    #   ci       = import ./devshells/ci.nix       { inherit pkgs unstable; };
    #   Have to write Kubernetes and docker, AWS, Rust, Python, SOPS... dev shells
    # };
    #
    nixosConfigurations = {

      Athena = mkHost {
        hostname = "Athena";
        hosts = "thinkpad-x1";
        hardwareModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
          nixos-hardware.nixosModules.common-cpu-intel
        ];
      };

      # Hestia = mkHost {
      #   hostname = "Hestia";
      #   hosts = "vm";
      #   hardwareModules = [];
      # };

      # future hardware — just add hardware-configuration.nix + pick a desktop
      # NewMachine = mkHost {
      #   hostname = "NewMachine";
      #   desktop = "noctalia";
      #   hardwareModules = [ nixos-hardware.nixosModules.common-cpu-amd ];
      # };
    };
  };
}
