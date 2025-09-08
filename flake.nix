{
  description = "Ayush Flakes";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = {self, nixpkgs, ...}:
    let 
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      ayush = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./configuration.nix];
      };
    };
  };
}
