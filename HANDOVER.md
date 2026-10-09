# Handover: new dotfiles adjustment

Date: 2026-10-09
Repository: `/home/yielco/git/new_dotfiles`
Branch: `main`
Latest commit at handover: `b7d5542 Bind Alt-x to Herdr tab close`

## Current repository state

Clean at handover before this file was created.
Recent commits:

- `b7d5542` Bind Alt-x to Herdr tab close
- `d416a5d` Bind Herdr new tab to prefix t
- `6a964bf` Bind Herdr reload to prefix r
- `98338a6` Fix Herdr tab switch helper
- `09497af` Add n alias for nnn
- `1b62f1e` Configure Herdr in chezmoi
- `b1648d4` Initial cross-platform chezmoi and mise setup

This handover file itself is newly created and is not committed unless explicitly committed later.

## Important workflow notes

Use the clean repository:

```sh
cd /home/yielco/git/new_dotfiles
```

Apply managed files with explicit source:

```sh
chezmoi --source /home/yielco/git/new_dotfiles -v apply <target-paths>
```

Validate Herdr changes before applying:

```sh
HERDR_CONFIG_PATH=/path/to/rendered/config.toml herdr config check
```

After applying live Herdr config:

```sh
herdr config check
herdr server reload-config
```

Do not test by applying the full home blindly. Use targeted apply or isolated destinations.

## Herdr status and configuration

Managed Herdr source:

- `dot_config/herdr/config.toml.tmpl`
- `dot_config/herdr/bin/executable_switch-tab`

Rendered live targets:

- `~/.config/herdr/config.toml`
- `~/.config/herdr/bin/switch-tab`

Herdr is managed only for non-Windows profiles via `.chezmoiignore`.

Current keybindings in source:

```toml
[keys]
prefix = "ctrl+space"
reload_config = "prefix+r"
resize_mode = ""
new_tab = "prefix+t"
split_vertical = ["prefix+v", "prefix+|", "prefix+backslash"]
split_horizontal = ["prefix+h", "prefix+minus", "prefix+shift+minus"]
focus_pane_left = ""
focus_pane_down = ""
focus_pane_up = ""
focus_pane_right = ""
last_pane = "alt+w"
cycle_pane_next = "alt+j"
cycle_pane_previous = "alt+k"
close_pane = "prefix+x"
next_tab = "alt+shift+j"
previous_tab = "alt+shift+k"
close_tab = "alt+x"
```

Letter-based tab switching uses custom commands:

- `Alt+a` -> switch to ordinal tab 1, or create one tab if missing
- `Alt+s` -> ordinal tab 2
- `Alt+d` -> ordinal tab 3
- `Alt+f` -> ordinal tab 4

The helper treats Herdr tab numbers as stable IDs with possible gaps, sorts by `number`, uses ordinal positions, and creates at most one focused tab if the ordinal is missing. This fixed a previous bug where `Alt+f` created tabs endlessly after tab numbers had gaps.

Important: `Alt+x` was changed from pane close to tab close because Herdr's built-in `close_tab` shows the confirmation overlay. Pane close is now `prefix+x`. `confirm_close = true` is set under `[ui]`.

Unsupported/left open:

- tmux-style synchronized pane input (`Alt+e`) is not implemented because Herdr 0.9.3 does not expose a real synchronized-input action in config/API. Do not fake it.

## mise/tooling status

Managed mise source:

- `dot_config/mise/config.toml.tmpl`

Relevant additions:

```toml
{{- if not .isWindows }}
herdr = "latest"
{{- end }}
"github:jarun/nnn" = { version = "latest", rename_exe = "nnn" }
```

`nnn` needed `rename_exe = "nnn"` because the GitHub release exposes `nnn-static` by default.

Verified live earlier:

```sh
mise exec -- nnn -V    # 5.3
mise exec -- herdr --version  # herdr 0.9.3
```

## Shell aliases

Managed files:

- Bash/Zsh: `dot_config/shell/aliases.sh`
- Fish: `dot_config/fish/config.fish.tmpl`

Added alias/abbr:

- Bash/Zsh: `alias n='nnn'`
- Fish: `abbr --add n nnn`

Validation used:

```sh
bash -n dot_config/shell/aliases.sh
fish -n <rendered fish config>
```

## Last known live Herdr workspace cleanup

A previous runaway tab creation bug created hundreds of Herdr tabs. All tabs except the first three were closed. At that time the remaining tabs were:

- `wA:t1` label `hermes`
- `wA:t2` label `term`
- `wA:t4` label `3`

## Suggested next steps

1. Decide whether this `HANDOVER.md` should be committed, moved elsewhere, or deleted.
2. Continue refining Herdr ergonomics now that core tab/pane bindings are stable.
3. Consider whether `prefix+x` for pane close is acceptable after moving `Alt+x` to confirmed tab close.
4. If Herdr later exposes synchronized pane input, add `Alt+e` properly and validate with `herdr config check`.
5. Consider adopting a `mise.lock` if reproducibility becomes more important than tracking `latest`.
