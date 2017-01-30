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


