# dotfiles

This repository contains my personal dotfiles. It is not perfect, but will become a useful tool configuration for me (eventually).
*Note to my future self:* I tried to comment where possible and also to add the sources wherever possible. These often contain other valuable information or links, so maybe check them occassionally...

For getting them up and running:

- Clone them to a directory of your likening
- I used to create symbolic links in the home folder to the single files / folders accordingly.
    - On \*nix-systems use `ln -s`
    - On windows use `mklink [/d] <link> <source>`, where the optional parameter `/d` has to be used for directories. Hard links can be created using `/h`
- emacs should contact elpa / other repositories automatically and download the missing packages
- for tmux you have to install the plugin manager [tmp](https://github.com/tmux-plugins/tpm) (mostly cloning)
- then you can hit <kbd>prefix</kbd>`-I` (capital `I` as in *I*nstall) in order to download and activate the plugins

Now I also added the files for [neovim](https://neovim.io/). But man: compared
to when I initially tried it on Windows, it is a mess:
- The QT-version doesn't support dead keys. Oh my... It's a bug, but not fixed yet
- Configuration of the shell version is also painful: fonts / cursors not always
  working properly, forget it if you want to run it in cygwin, ...
- You need to configure Python 2 / Python 3 something, set a lot of environment
  variables... painful.
- Currently playing with the idea of configuring a WSL with ArchLinux and then
  running i3 in X. Let's see...

At least it uses some default configuration conventions (in *nix). So ensure
- that you have a `%USERPROFILE%/.config/nvim`-folder and
- that you point the environment variable `XDB_CONFIG_HOME` to this folder
- that you have a `%USERPROFILE%/.local`-folder and 
- that you point the environment variable `XDB_DATA_HOME` to this folder
- Also set `TERM` to `xterm-256color`
- Set `NVIM` to the home-directory of your nvim installation (not `bin`-folder)
- Setting `HOME` to `%USERPROFILE` is mainly for cygwin, but helps here as well.

### TODOs / ideas

- After adjusting the cygdrive mapping in cygwin as described in [A Proper Cygwin Environment](http://randomartifacts.blogspot.de/2012/10/a-proper-cygwin-environment.html) I could try it once more if the symbolic links are working correctly and emacs finds its folders.
- Add all the vim files
- Some script to automate the linking process after cloning (see maybe Aaron Bieber's repo)
- Split up bash-configuration:
    - aliases in their own file
    - check for cygwin and put all cygwin specific settings there
    - system-specific settings in their own file (i.e. work vs. home)
- Put the git aliases into its own file and include this one in `.gitconfig`

TODOs:

- be inspired by some tools / dotfiles discovered [here](https://dotfiles.github.io/) or [here](http://dotshare.it/)
- add vim-files
- remove `ls`-alias
- put aliases in their own file
- distinguish between cygwin / bash / zsh / ssh-session
- [LiquidPrompt](https://github.com/nojhan/liquidprompt)?
- Make it work with symbolic links again, maybe by using [GNU Stow](https://www.gnu.org/software/stow/) or some other tool from the sites above?
- There are some articles to create vimfiles that can be run by either nvim as 
  well as by vim. Question: does it pay off? Will I ever use vim again?

[Good introduction](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.v3g4lz8s8), btw...

