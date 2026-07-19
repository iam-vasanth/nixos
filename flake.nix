{
  description = "NixOS flake - Athena.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
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
    home-manager,
    niri,
    dms,
    nixos-hardware,
    sops-nix,
    nix-flatpak,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    hostname = "Athena";
    user = "zoro";
    desktop = "niri-dms";

    pkgs = nixpkgs.legacyPackages.${system};
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
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

    mkHost = {hostname, host, hardwareModules ? [], desktop, vm ? false}: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs hostname user unstable;};

      modules = [
        ./hosts/configuration.nix
        ./hosts/${hosts}/disko.nix
        ./hosts/${hosts}/hardware-configuration.nix

        {
          nix.desktop = desktop;
          nix.vm.enable = vm;
        }

        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        niri.nixosModules.niri
        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.extraSpecialArgs = {inherit inputs user hostname unstable;};
          home-manager.sharedModules = [
            sops-nix.homeManagerModules.sops
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
        }
      ] ++ hardwareModules;
    };

    nixosConfigurations = {
      Ares = mkHost {
        hostname = "Ares";
        host = "thinkpad-x1"
        desktop = "dms";
        hardwareModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
          nixos-hardware.nixosModules.common-cpu-intel
        ];
      };

      Athena = mkHost {
        hostname = "Athena";
        host = "thinkpad-x1"
        desktop = "noctalia";
        hardwareModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
          nixos-hardware.nixosModules.common-cpu-intel
        ];
      };

      Hestia = mkHost {
        hostname = "Hestia";
        desktop = "dms";
        vm = true;
        hardwareModules = [];
      };

      # future hardware — just add hardware-configuration.nix + pick a desktop
      # NewMachine = mkHost {
      #   hostname = "NewMachine";
      #   desktop = "noctalia";
      #   hardwareModules = [ nixos-hardware.nixosModules.common-cpu-amd ];
      # };
    };
  };
}
