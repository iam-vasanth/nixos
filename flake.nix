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

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    sops-nix.url = "github:mic92/sops-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
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

    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs hostname user desktop unstable;};

      modules = [
        ./configuration.nix

        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        niri.nixosModules.niri

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.extraSpecialArgs = {inherit inputs user hostname desktop unstable;};
          home-manager.sharedModules = [
            sops-nix.homeManagerModules.sops
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
        }

        nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
        nixos-hardware.nixosModules.common-cpu-intel
      ];
    };
  };
}
