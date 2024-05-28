{ pkgs, misc, ... }: {
   home.shellAliases = {
    "apply-tafltc" = "nix run --impure home-manager/master -- -b bak switch --flake .#sysop@tafltc";
    
    # some more ls aliases
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
    "nx" = "nix run --impure home-manager/master -- -b bak switch --flake .#sysop@tafltc";

    # bat --plain for unformatted cat
    catp = "bat -P";
    
    # replace cat with bat
    cat = "bat";
    };
}
