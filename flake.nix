{
  description = "NixOS configurations for momiji, fuchsia, pawass, and keyaki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/v0.8.0";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.2.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    freesm = {
      url = "github:freesmteam/freesmlauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:4evy/nixcord";
      inputs.nixpkgs-packages.follows = "nixpkgs-unstable";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    calagopus = {
      url = "github:wanivy/nix-calagopus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    ...
  }: let
    hostSystems = {
      momiji = "x86_64-linux";
      fuchsia = "x86_64-linux";
      pawass = "x86_64-linux";
      keyaki = "x86_64-linux";
    };
    supportedSystems = nixpkgs.lib.unique (builtins.attrValues hostSystems);
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    unstableOverlay = final: _prev: {
      unstable = import nixpkgs-unstable {
        system = final.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    };
    localPackagesOverlay = final: _prev: {
      localPackages = import ./packages {pkgs = final;};
    };

    commonModules = [
      inputs.disko.nixosModules.disko
      {nixpkgs.overlays = [unstableOverlay localPackagesOverlay];}
    ];

    mkNixosSystem = {
      modules,
      specialArgs ? {},
      system,
    }:
      nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = commonModules ++ modules;
      };
  in {
    nixosConfigurations = {
      momiji = mkNixosSystem {
        system = hostSystems.momiji;
        specialArgs = {inherit inputs nixpkgs-unstable;};
        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.lanzaboote.nixosModules.lanzaboote
          ./hosts/momiji
          {
            home-manager = {
              sharedModules = [
                inputs.zen-browser.homeModules.beta
                inputs.spicetify.homeManagerModules.spicetify
                inputs.nixcord.homeModules.nixcord
              ];
              extraSpecialArgs = {
                inherit (inputs) agenix freesm spicetify;
              };
            };
          }
        ];
      };

      fuchsia = mkNixosSystem {
        system = hostSystems.fuchsia;
        specialArgs = {inherit inputs;};
        modules = [
          inputs.agenix.nixosModules.default
          inputs.calagopus.nixosModules.default
          {nixpkgs.overlays = [inputs.calagopus.overlays.default];}
          ./hosts/fuchsia
        ];
      };

      pawass = mkNixosSystem {
        system = hostSystems.pawass;
        specialArgs = {inherit inputs;};
        modules = [./hosts/pawass];
      };

      keyaki = mkNixosSystem {
        system = hostSystems.keyaki;
        specialArgs = {inherit inputs;};
        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./hosts/keyaki
          {
            home-manager = {
              sharedModules = [
                inputs.zen-browser.homeModules.beta
                inputs.spicetify.homeManagerModules.spicetify
                inputs.nixcord.homeModules.nixcord
              ];
              extraSpecialArgs = {
                inherit (inputs) freesm spicetify;
              };
            };
          }
        ];
      };
    };

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
