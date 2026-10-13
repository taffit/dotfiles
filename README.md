# Cross-platform dotfiles

A clean chezmoi source repository for Windows, Linux, Arch Linux, and WSL.
Development tools and language runtimes are managed with mise.

## Managed platforms

- Windows with PowerShell 7
- General Linux distributions
- Arch Linux
- WSL

On Linux, Arch, and WSL the repository installs configuration for Bash, Zsh,
and Fish. Fish is the preferred shell and can optionally be selected as the
login shell during initialization.

## Bootstrap

Install Git and chezmoi first, then initialize this repository:

    chezmoi init --apply /path/to/new_dotfiles

When the repository has a remote:

    chezmoi init --apply https://example.com/user/dotfiles.git

Initialization asks for:

- Git display name
- Git email address
- Git hosting username
- machine role (`personal`, `work`, or `server`)
- platform profile (`linux`, `arch`, `wsl`, or `windows`)
- whether system shell packages should be installed
- whether Fish should become the default login shell
- whether mise should install all declared tools

Chezmoi detects the likely platform and offers it as the default. The explicit
answer is stored in the local chezmoi config so it can be overridden when
needed.

## Daily workflow

    chezmoi status
    chezmoi diff
    chezmoi apply -v

Edit a managed target through chezmoi:

    chezmoi edit --apply ~/.config/fish/config.fish

Update this repository from a managed target:

    chezmoi re-add ~/.config/fish/config.fish

## mise

The global mise config is installed at `~/.config/mise/config.toml`.

Useful commands:

    mise config ls
    mise ls --current
    mise install
    mise outdated --bump
    mise upgrade --dry-run
    mise doctor

Shell activation is configured for Bash, Zsh, Fish, and PowerShell.

## Zellij

Zellij is installed by mise and reads `~/.config/zellij/config.kdl`.
The custom shortcuts are available outside Zellij's locked mode:

- `Alt+a/s/d/f`: switch directly to the existing tab 1/2/3/4
- `Alt+t`: create and focus a new tab
- `Alt+Shift+f`: toggle floating panes
- `Alt+e`: toggle synchronized input for all panes in the active tab
- `Alt+j/k`: focus the next/previous pane
- `Alt+\\`, `Alt+|`, or `Alt+v`: create a pane to the right
- `Alt+-`, `Alt+_`, or `Alt+h`: create a pane below
- `Alt+m`: toggle fullscreen for the focused pane
- `Alt+x`: close the active tab

## Windows Terminal multi-line input

On WSL, chezmoi configures Windows Terminal so `Shift+Enter` sends a line feed
(`Ctrl+J`). This gives Hermes a reliable multi-line shortcut through terminal
multiplexers such as Herdr, where the outer terminal otherwise cannot distinguish
`Shift+Enter` from plain `Enter`.

The run-on-change script updates only the named action and the `shift+enter`
keybinding in the existing Windows Terminal `settings.json`; profiles, themes,
and other bindings are retained. Before the first rewrite it saves
`settings.json.chezmoi-backup` beside the original file. The mapping is global
to Windows Terminal and therefore applies to every profile and nested
multiplexer.

## Local configuration

Keep machine-only shell customizations outside the repository:

- POSIX shells: `~/.config/shell/local.sh`
- Fish: `~/.config/fish/conf.d/local.fish`
- PowerShell: `~/.config/powershell/local.ps1`

## Design principles

- one chezmoi source root; no redirected `.chezmoiroot`
- explicit platform profile stored as chezmoi data
- platform-specific targets selected through `.chezmoiignore`
- system package installation is optional
- bootstrap scripts are idempotent and platform-scoped
- mise owns development tools and runtimes, not base operating-system packages
