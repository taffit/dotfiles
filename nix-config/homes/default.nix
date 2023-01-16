{ home-manager, nixpkgs, dotfiles, ... }: {

  "sysop@x86_64-linux" = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #user = "sysop";
    extraSpecialArgs = {
      #inherit user dotfiles;
      inherit dotfiles;
    };
    modules = [
      ./home.nix
    ];
  };

}
