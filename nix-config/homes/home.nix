{ pkgs, user, dotfiles, ... }: {
  fonts.fontconfig.enable = true;
  home = {
    # TODO Use a variable provided to the script
    #username = "${user}";
    #homeDirectory = "/home/${user}";
    username = "sysop";
    homeDirectory = "/home/sysop";
    stateVersion = "22.11";
    enableNixpkgsReleaseCheck = true;
    sessionVariables = {
      EDITOR = "nvim";
      CPATH = "/usr/include:/usr/include/x86_64-linux-gnu";
      #LD_LIBRARY_PATH = "/usr/lib:/usr/lib/x86_64-linux-gnu:/usr/local/lib:$LD_LIBRARY_PATH";
    };
    shellAliases = {
      l = "ls -als --color";
      d = "docker run --rm -it";
      dc = "docker compose";
      hm = "home-manager";
      n = "nnn";
      ".." = "cd ..";
      "..." = "cd ../..";
      "nxs" = "nix run . switch -- --flake .";
    };
    packages = with pkgs; [
      cmake
      cowsay
      coreutils-full
      curl
      cyrus_sasl
      docker
      docker-compose
      fd  # Better file find, used by telescope
      gcc
      git
      glibc
      gnumake
      httpie
      (nerdfonts.override { fonts = [
        "FantasqueSansMono" "FiraCode" "FiraMono"
      ]; })
      nixfmt
      nixpkgs-fmt
      nnn
      nodejs
      nodePackages.npm
      nodePackages.prettier
      openldap
      python3Full
      #(python3.withPackages (ps: with ps; [
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
      #  #numpy
      #  #pandas
      #  #jupyter
      #  #scipy
      #  setuptools
      #  wheel
      #])
      #)a
      openssl
      ripgrep  # used by telescope
      rclone
      rsync
      sqlitebrowser
      tree
      tree-sitter
      wget

      # Fonts
      fontconfig
      fira-code
      fira-code-symbols
      fantasque-sans-mono
    ];
  };
  programs = {
    home-manager.enable = true;
    man.enable = true;
    vim.enable = true;
    zsh.enable = true;
    bash = {
      enable = true;
      # TODO use variables provided
      bashrcExtra = builtins.readFile "${dotfiles}/.bashrc";
      profileExtra = builtins.readFile "${dotfiles}/.profile";
      #bashrcExtra = builtins.readFile ".dotfiles/.bashrc";
      #profileExtra = builtins.readFile ".dotfiles/.profile";
    };
    tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      prefix = "C-a";
      terminal = "xterm-256color";
      extraConfig = ''
				######################
				## General settings ##
				######################
      	# Set the delay so that it doesn't interfere with applications like vim
				set -sg escape-time 0

				# Make window and pane indexes start with 1
				set -g base-index 1
				setw -g pane-base-index 1

				# Use vi key bindings
				set -g status-keys vi
				setw -g mode-keys vi

				# force tmux to use utf-8
				setw -gq utf8 on

				# activate mouse in tmux
				set -g mouse on

				# increasing timeout to switch ppane on <prefix>-q
				set -g display-panes-time 4000 # cancel with ESC

				# Add more scroll history to the buffer
				set -g history-limit 100000

				# Ensure window titles get renamed automatically
				setw -g automatic-rename on
				set -g set-titles on

				##################
				## Key bindings ##
				##################
				# The following rebindings need the prefix before the keys!
				# split panes using | and - (instead of % and ")
				unbind %
				bind | split-window -h
				bind v split-window -h
				unbind '"'
				bind - split-window -v
				bind h split-window -v

				# Go to last window
				bind-key -n M-w last-window

				################
				## Appearance ##
				################
				# Show notices when there is activity on another window
				setw -g monitor-activity on
				set -g visual-activity off
				# Visual bell
				set -g visual-bell on

				# Theme based on tmuxline
				#source-file ~/.tmux/tmuxline.tmux

				#################
				## Status line ##
				#################
				# Force utf-8
				set -gq status-utf8 on

				# Refresh every minute
				set -g status-interval 30
      '';
      # https://rycee.gitlab.io/home-manager/options.html
      plugins = with pkgs; [
        tmuxPlugins.gruvbox
        tmuxPlugins.vim-tmux-navigator
        {
          plugin = tmuxPlugins.tilish;
          extraConfig = ''
						# Settings for tmux-tilish
						set -g @tilish-shiftnum '!@#$%^&*()'
						set -g @tilish-dmenu 'on'
						set -g @tilish-default 'tiled'
						
						#########################
            ## QTile-like bindings ##
						#########################
						# Switch to workspace via Alt + #.
						#bind_switch "${mod}a" 1
						#bind_switch "${mod}s" 2
						#bind_switch "${mod}d" 3
						#bind_switch "${mod}f" 4
						#bind_switch "${mod}u" 5
						#bind_switch "${mod}i" 6
						#bind_switch "${mod}o" 7
						#bind_switch "${mod}p" 8
          '';
        }
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
      userName = "David Siller";
      # TODO Depending on the host, the git-e-mail is different
      userEmail = "taffit@gmail.com";
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
  xdg.configFile."nvim" = {
    source = ../dotfiles/nvim;
    recursive = true;
  };
}
