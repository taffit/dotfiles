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
      # In order to make some paging working correctly (e. g. for rich in Python)
      PAGER = "less -r";
    };
    shellAliases = {
      l = "ls -als --color";
      d = "docker run --rm -it";
      dc = "docker compose";
      hm = "home-manager";
      hmg = "home-manager generations";
      hmrmg = "home-manager remove-generations";
      hmxg = "home-manager expire-generations";
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
      gcc-unwrapped # for libstrdc++.so.6
      git
      glibc
      gnumake
      go
      graphviz
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
      nixfmt
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
      prefix = "C-Space";
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

# Activate the clipboard
set -g set-clipboard on

##################
## Key bindings ##
##################
# Edit configuration
bind e new-window -n '~/.tmux.conf' run-shell 'sh -c "''${EDITOR:-vim} ~/.tmux.conf && tmux source ~/.tmux.conf && tmux display `~/.tmux.conf sourced`"'

# Source config-file
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# The following rebindings need the prefix before the keys!
# split panes using | and - (instead of % and ")
unbind %
bind-key "|" split-window -h -c "#{pane_current_path}"
bind-key "\\" split-window -fh -c "#{pane_current_path}"
bind-key "v" split-window -h -c "#{pane_current_path}"
unbind '"'
bind-key "-" split-window -v -c "#{pane_current_path}"
bind-key "_" split-window -fv -c "#{pane_current_path}"
bind-key "h" split-window -v -c "#{pane_current_path}"

# Go to last window
bind-key -n M-w last-window

###########
## Panes ##
###########
# Selecting panes by using C-x
bind-key -n F1 select-pane -t 1
bind-key -n F2 select-pane -t 2
bind-key -n F3 select-pane -t 3
bind-key -n F4 select-pane -t 4
bind-key -n F5 select-pane -t 5
bind-key -n F6 select-pane -t 6
bind-key -n F7 select-pane -t 7
bind-key -n F8 select-pane -t 8
bind-key -n F9 select-pane -t 9
bind-key -n F10 select-pane -t 0

# Enable / disable pane synchronization
# Note: if you don't specify on / off, the option is toggled
bind -n "M-e" setw synchronize-panes

# bind -n M-h run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
# bind -n M-j run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
# bind -n M-k run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
# bind -n M-l run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
# Just next/previous pane
# bind -n M-j run "(tmux display-message -p '#{pane_title}' | grep -iq nvim && tmux send-keys C-j) || tmux select-pane -t :.+"
# bind -n M-k run "(tmux display-message -p '#{pane_title}' | grep -iq nvim && tmux send-keys C-k) || tmux select-pane -t :.-"
bind -n "M-j" select-pane -t :.+
bind -n "M-k" select-pane -t :.-

bind -n "M-a" if-shell "tmux select-window -t 1" "" "new-window -t 1"
bind -n "M-s" if-shell "tmux select-window -t 2" "" "new-window -t 2"
bind -n "M-d" if-shell "tmux select-window -t 3" "" "new-window -t 3"
bind -n "M-f" if-shell "tmux select-window -t 4" "" "new-window -t 4"
bind -n "M-u" if-shell "tmux select-window -t 5" "" "new-window -t 5"
bind -n "M-i" if-shell "tmux select-window -t 6" "" "new-window -t 6"
bind -n "M-o" if-shell "tmux select-window -t 7" "" "new-window -t 7"
bind -n "M-p" if-shell "tmux select-window -t 8" "" "new-window -t 8"

bind -n "M-0" select-pane -t 'bottom-right' \; split-window \; run-shell 'tmux select-layout tiled' #\; send escape

bind -r "M-<" swap-window -d -t -1
bind -r "M->" swap-window -d -t +1

# Maximizing/minimizing pane
bind -n "M-m" resize-pane -Z

# Close a window/pane with Alt+x
bind -n "M-x" kill-pane

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
#        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.yank
#         {
#           plugin = tmuxPlugins.tilish;
#           extraConfig = ''
# # settings for tmux-tilish
# set -g @tilish-shiftnum "!@#$%^&*()"
# set -g @tilish-dmenu "on"
# set -g @tilish-default "tiled"
#
# ## Read user options.
# #for opt in default dmenu easymode navigate navigator prefix shiftnum
# #do
# #	export "$opt"="$(tmux show-option -gv @tilish-"$opt" 2>/dev/null)"
# #done
# #
# ## Determine modifier vs. prefix key.
# #if [ -z "''${prefix:-}" ]
# #then
# #  bind="bind -n"
# #  mod="M-"
# #else
# #  bind="bind -rT tilish"
# #  mod=""
# #fi
#
# # Define core functionality {{{
# bind_switch () {
# 	# Bind keys to switch between workspaces.
# 	tmux $bind "$1" \
# 		if-shell "tmux select-window -t :$2" "" "new-window -t :$2"
# }
#
# ## Define keybindings
# ## Define a prefix key.
# #if [ -n "$prefix" ]
# #then
# #	tmux bind -n "$prefix" switch-client -T tilish
# #fi
#
# #########################
# ## qtile-like bindings ##
# #########################
# # switch to workspace via alt + #.
# #bind_switch "''${mod}a" 1
# #bind_switch "''${mod}s" 2
# #bind_switch "''${mod}d" 3
# #bind_switch "''${mod}f" 4
# #bind_switch "''${mod}u" 5
# #bind_switch "''${mod}i" 6
# #bind_switch "''${mod}o" 7
# #bind_switch "''${mod}p" 8
# bind_switch "M-a" 1
# bind_switch "M-s" 2
# bind_switch "M-d" 3
# bind_switch "M-f" 4
# bind_switch "M-u" 5
# bind_switch "M-i" 6
# bind_switch "M-o" 7
# bind_switch "M-p" 8
#           '';
#         }
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
