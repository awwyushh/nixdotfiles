{
  description = "Ayush Flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };	
  };

  outputs = { self, nixpkgs, home-manager, nix4nvchad, ... }:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        ayush = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };

      homeConfigurations = {
        ayush = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit nix4nvchad;
          };
        };
      };
    };
}

