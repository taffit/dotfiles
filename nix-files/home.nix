{ config, pkgs, misc, ... }: {
  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
      
      
    };
  };

  
  # packages are just installed (no configuration applied)
  # programs are installed and configuration applied to dotfiles
  # The `with pkgs;` saves us prefixing every package with `pcks.`
  home.packages = with pkgs; [
    # user selected packages
    cmake
    cowsay
    coreutils-full
    curl
    cyrus_sasl
    docker
    docker-compose
    fd  # Better file find, used by telescope
    fzf
    gcc
    gcc-unwrapped # for libstrdc++.so.6
    git
    glibc
    gnumake
    go
    graphviz
    htop
    httpie
    hyperfine
    libxml2
    libxslt
    libzip
    lua5_3
    luarocks-nix
    #(lua5_3Packages.luarocks)
    (nerdfonts.override { fonts = [
      "FantasqueSansMono" "FiraCode" "FiraMono"
    ]; })
    nixfmt-rfc-style
    nixpkgs-fmt
    nnn
    nodejs
    nodePackages.npm
    nodePackages.prettier
    openldap
    p7zip
    python3Full
    # (python3.withPackages (ps: with ps; [
    #  #jax
    #  #jaxlib
    #  #pytorch
    #  #tensorflow
    #  #librosa
    #  #matplotlib
    #  #mypy
    #  black
    #  devtools
    #  #scikit-learn
    #  flake8
    #  pip
    #  python-ldap
    #  #ipython
    #  #isort
    # numpy
    # pandas
    # jupyter
    # jupyterlab
    #  #scipy
    #  setuptools
    #  wheel
    # ])
    # )
    openssl
    ripgrep  # used by telescope
    rclone
    rsync
    sqlitebrowser
    tree
    tree-sitter
    unzip
    wget
    xdg-utils
    xsel
    zlib

    # Fonts
    fontconfig
    fira-code
    fira-code-symbols
    fantasque-sans-mono

    # Fleek Bling
    #pkgs.github-cli
    #pkgs.glab
    #pkgs.lazygit
    #pkgs.jq
    #pkgs.yq-go
    #pkgs.neovim
    #pkgs.neofetch
    #pkgs.btop
    #pkgs.cheat
    #pkgs.just
    #(pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  fonts.fontconfig.enable = true; 
  home.stateVersion =
    "22.11"; # To figure this out (in-case it changes) you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;
}
