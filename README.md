## `dotfiles` revised
After a fruitless excursion into the world of `nix`/`home-manager`/`fleek` (well, had it running _somehow_
for some months, but man, what ... individuals ... in the community and how complicated and confusing it is)
I found a [blog entry](https://www.rousette.org.uk/archives/a-tour-around-chezmoi/) that made me curious (let
me thank you once more!]. So I tried out the [chezmoi](https://www.chezmoi.io/)/[mize-en-place](https://mise.jdx.dev/)
and wow! Working instantly (after some fiddling, but hey, we're talking about `dotfiles` after all :-) ).

### Setup
- Ensure you have `git`, ... installed and configured.
- Install [chezmoi](https://www.chezmoi.io/install/)
- Initialize it using this github repo: `chezmoi init https://github.com/taffit/dotfiles.git`
- Install [mize-en-place](https://mise.jdx.dev/getting-started.html#_1-install-mise-cli) and activate it (or simply log out and in once)
- Start `nvim`, let it install all configured requirements, linters, LSP server, ...

That. Is. It.    
Let me use all the spare time won using these tools to think about the cumbersome experiments I had to do 
before this experience ... Great!
