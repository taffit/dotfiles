{
  description = "Based on Fleek configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                  # Nix Packages

    # Home manager
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {                                                      # User Package Management
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Overlays
    

  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }@inputs:
  # let
  #   dotfiles = "./dotfiles";
  # in
  {
    
    # Available through 'home-manager --flake .#your-username@your-hostname'
    
    homeConfigurations = {
    
      "sysop@tafltc" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs;
          vars = {
            dotfiles = "./dotfiles";
          };
        }; # Pass flake inputs to our config
        modules = [
          ./home.nix 
          ./path.nix
          ./shell.nix
          ./user.nix
          ./aliases.nix
          ./programs.nix
          # Host Specific configs
          ./tafltc/sysop.nix
          ./tafltc/custom.nix
          # self-manage fleek
          {
            home.packages = [];
          }
          ({
           nixpkgs.overlays = [];
          })
        ];
      };
      
    };
  };
}
