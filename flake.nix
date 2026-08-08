{
  description = "NixOS flake - Athena.";

  # Noctalia cachix
  nixConfig = {
    extra-substituters = ["https://noctalia.cachix.org"];
    extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
      inputs.nixpkgs.follows = "";
      inputs.hjem.follows = "";
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    sops-nix.url = "github:mic92/sops-nix";

    disko.url = "github:nix-community/disko";

    impermanence.url = "github:nix-community/impermanence";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    lazyvim.url = "github:pfassina/lazyvim-nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    hjem,
    mangowm,
    nixos-hardware,
    sops-nix,
    disko,
    impermanence,
    nix-flatpak,
    lazyvim,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "zoro";

    overlays = import ./overlays {inherit inputs;};

    paths = {
      dots = ./dots;
      devsh = ./devshells;
    };

    impure = {
      dots = "${paths.dots}";
      dotsImpure = "/home/${user}/Projects/nixos/dots";
    };

    pkgs = nixpkgs.legacyPackages.${system};
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
      overlays = overlays;
    };
    mkHost = {
      hostname,
      hardwareModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs hostname user unstable overlays paths impure;};

        modules =
          [
            ./hosts/default.nix
            ./hosts/${hostname}/default.nix
            ./hosts/${hostname}/disko.nix
            ./hosts/${hostname}/hardware-configuration.nix
            ./modules/default.nix

            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            sops-nix.nixosModules.sops
            mangowm.nixosModules.mango
            hjem.nixosModules.default
            nix-flatpak.nixosModules.nix-flatpak
          ]
          ++ hardwareModules;
      };
  in {
    formatter.${system} = pkgs.alejandra;

    devShells.${system} = {
      devops = import (paths.devsh + /devops.nix) {inherit pkgs unstable;};
      rust = import (paths.devsh + /rust.nix) {inherit pkgs unstable;};
      java = import (paths.devsh + /java.nix) {inherit pkgs unstable;};
      python = import (paths.devsh + /python.nix) {inherit pkgs unstable;};
      go = import (paths.devsh + /go.nix) {inherit pkgs unstable;};
    };

    nixosConfigurations = {
      Athena = mkHost {
        hostname = "Athena";
        hardwareModules = [
          nixos-hardware.nixosModules.asus-fa506ic
        ];
      };

      Ares = mkHost {
        hostname = "Ares";
        hardwareModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
          nixos-hardware.nixosModules.common-cpu-intel
        ];
      };

      Hestia = mkHost {
        hostname = "Hestia";
        hardwareModules = [];
      };

      # future hardware — just add hardware-configuration.nix
      # NewMachine = mkHost {
      #   hostname = "NewMachine";
      #   hardwareModules = [ nixos-hardware.nixosModules.common-cpu-amd ];
      # };
    };
  };
}
