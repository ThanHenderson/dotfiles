{
  description = "Home Manager configuration of than";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        legacyPackages = system;
        config.allowUnfree = true;
      };
    in {
    defaultPackage.${system} =
      home-manager.defaultPackage.${system};
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      homeConfigurations."than" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}
