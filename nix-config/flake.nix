{
  description = "My personal home-manager and nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                  # Nix Packages

    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {                                                      # User Package Management
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, home-manager }:
  let
    dotfiles = ./dotfiles;
  in
  {
    homeConfigurations = import ./homes { inherit home-manager nixpkgs dotfiles; };
  } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter = pkgs.nixfmt;

      apps = rec {
        update-home = import ./homes/update-home.nix { inherit pkgs; };
        default = update-home;
      };

      devShells = rec {
        home-manager = import ./homes/shell.nix { inherit pkgs dotfiles; };
        default = home-manager;
      };
    }
  );
}
