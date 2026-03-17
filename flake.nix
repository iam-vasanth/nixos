{
  description = "My NixOS multi-host flake (Niri-Noctalia / Niri-DMS / Cosmic)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    # lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1";
    disko.url = "github:nix-community/disko";
    sops-nix.url = "github:mic92/sops-nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    niri-flake,
    noctalia,
    dms,
    nixos-hardware,
    disko,
    sops-nix,
    nix-flatpak,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;

    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = lib.genAttrs systems;

    user = "zoro";

    mkHost = {
      hardware,
      hostname,
      system ? "x86_64-linux",
      profile,
      desktop ? null,
      extraModules ? [],
      hardwareModules ? [],
    } @ args: let
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      profileModules = {
        desktop = [

          # Default desktop configuration.nix
          ./modules/profiles/desktop/default.nix

          # Default desktop home.nix
          # ./modules/profiles/desktop/home.nix

          # It has the DE specific configurations
          ./desktop/${desktop}/configuration.nix

        ];
        server = [

          # Default server configuration.nix
          ./modules/profiles/server/server.nix

          # Default server home.nix
          # ./modules/profiles/server/home.nix

        ];
        vm-desktop = [

          # VM specific configuration
          ./modules/profiles/vm.nix

          # Default desktop configuration.nix
          ./modules/profiles/desktop/default.nix

          # Default desktop home.nix
          # ./modules/profiles/desktop/home.nix

          # DE specific configuration
          ./desktop/${desktop}/configuration.nix

        ];
        vm-server = [

          # VM specific configuration
          ./modules/profiles/vm.nix

          # Default server home.nix
          ./modules/profiles/server/home.nix

          # Default server configuration.nix
          ./modules/profiles/server/server.nix

        ];

        # server-headless = [
        #   ./modules/profiles/server.nix
        # ];
        # container = [ ...container.nix ];
      };
      selectedProfileModules =
        profileModules.${profile} or (throw "Unknown profile '${profile}' for host '${hostname}'.\nKnown profiles: ${builtins.toString (builtins.attrNames profileModules)}");
      _assert =
        if (profile == "desktop" || profile == "vm-desktop") && desktop == null
        then throw "Host '${hostname}': profile=desktop but desktop argument is missing"
        else if !(profile == "desktop" || profile == "vm-desktop") && desktop != null
        then throw "Host '${hostname}': profile=${profile} but desktop=${desktop} was passed (should be null)"
        else null;
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs user hostname profile desktop unstable;
        };

        modules =
          [
            # Shared base config (move your common stuff here)
            # ./hosts/common/default.nix

            # lanzaboote.nixosModules.lanzaboote
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager

            # Can be disabled in host specific configurations with,
            # niri-flake.nixosModules.niri.enable = false;

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit inputs desktop unstable;};
            }
          ] ++ selectedProfileModules ++ extraModules ++ hardwareModules;
      };
  in {
    # Formatter
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Overlays
    overlays.default = import [
      ./modules/overlays
      niri-flake.overlays.niri
    ];

    # # Reusable modules
    # nixosModules = import ./modules/nixos;
    # homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      # ThinkPad variants
      Athena = mkHost {
        hardware = "Thinkpad x1";
        hostname = "Athena";
        profile = "desktop";
        desktop = "niri-noctalia";
        hardwareModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
          nixos-hardware.nixosModules.common-cpu-intel
        ];
      };

      Ares = mkHost {
        hardware = "Thinkpad x1";
        hostname = "Ares";
        profile = "desktop";
        desktop = "niri-dms";
        hardwareModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
          nixos-hardware.nixosModules.common-cpu-intel
        ];
      };

      Hera = mkHost {
        hardware = "Thinkpad x1";
        hostname = "Hera";
        profile = "desktop";
        desktop = "cosmic";
        hardwareModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
          nixos-hardware.nixosModules.common-cpu-intel
        ];
      };

      # Server
      Hades = mkHost {
        hostname = "Hades";
        profile = "server";
      };

      # VM - Virt-manager
      Hestia = mkHost {
        hardware = "Virtual machine";
        hostname = "Hestia";
        profile = "vm-desktop";
        desktop = "niri-dms";
      };

      # Example
      # Zeus = mkHost {
      #   hostname = "Zeus";
      #   profile = "desktop";
      #   desktop = Check /hosts/ folder for all profiles
      #   extraModules = [ ... ./common.nix ... ];
      #   hardwareModules = [ ... Hardware specific modules ... ];
      # };
    };
  };
}
