{ pkgs, misc, dotfiles, ... }: {
  # packages are just installed (no configuration applied)
  # programs are installed and configuration applied to dotfiles
  # add your personalized program configuration in ./user.nix   

  # Bling supplied programs 
    programs.bat.enable = true; 
    programs.zoxide.enable = true; 

  # User specified programs 
    programs.dircolors.enable = true;
    programs = {
    man.enable = true;
    vim.enable = true;
    zsh.enable = true;
    bash = {
      enable = true;
      # TODO use variables provided
      #bashrcExtra = builtins.readFile "${xdg.configHome}/nix-files/dotfiles/.bashrc";
      #bashrcExtra = builtins.readFile "$XDG_CONFIG_HOME/nix-files/dotfiles/.bashrc";
      #profileExtra = builtins.readFile "$XDG_CONFIG_HOME/nix-files/dotfiles/.profile";
    };
    tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      prefix = "C-Space";
      terminal = "xterm-256color";
      extraConfig = "";
      # https://rycee.gitlab.io/home-manager/options.html
      plugins = with pkgs; [
        tmuxPlugins.gruvbox
        tmuxPlugins.yank
        tmuxPlugins.resurrect
      ];
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      #git-user defined in specialized tafltc/sysop.nix
      #userName = "David Siller";
      #userEmail = "taffit@gmail.com";
      # TODO Play around with non-standard git diff extensions.
      delta.enable = false;
      diff-so-fancy.enable = false;
      difftastic.enable = false;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    gitui.enable = true;
    gh.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
  #home.file.".config/nvim".recursive = {
    #source = ./dotfiles/nvim;
  #};
  #xdg.configFile."nvim" = {
    #source = "$HOME/.config/nix-files/dotfiles/nvim";
    #recursive = true;
  #};
  xdg = {
    enable = true;
    configFile."nvim".source = ./dotfiles/.config/nvim;
    #configFile."nvim".source = ${vars.dotfiles}/.config/nvim;
    configFile."tmux".source = ./dotfiles/.config/tmux;
  };
}
