{ pkgs, misc, ... }: {
    #programs.eza.enableAliases = true;
    
    #programs.eza.extraOptions = [
   #"--group-directories-first"
   #"--header"
#];
    
    programs.bat.config = {
  theme = "TwoDark";
};
    # bash
  programs.bash.profileExtra = ''
    [ -r ~/.nix-profile/etc/profile.d/nix.sh ] && source  ~/.nix-profile/etc/profile.d/nix.sh
    export XCURSOR_PATH=$XCURSOR_PATH:/usr/share/icons:~/.local/share/icons:~/.icons:~/.nix-profile/share/icons

  '';
  programs.bash.initExtra = ''
    if [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi
  '';
  programs.bash.enableCompletion = true;
  programs.bash.enableVteIntegration = true;
  programs.bash.enable = true;
}
