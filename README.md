# Dotfiles

Cross-platform terminal configuration managed with Nix.
Works on macOS (nix-darwin) and Ubuntu/Linux (standalone home-manager).

## Adapt to your username

Open `flake.nix` and change the single line at the top of the `let` block:

```nix
username = "yourname"; # ← only line you need to change
```

Everything else — home directory, hostname, user account, flake output names — derives from it automatically.

---

## macOS Setup

```bash
# 1. Install Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Install Homebrew (needed for fonts and casks)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Clone and apply
git clone https://github.com/DennisRotondi/nix-dotfiles.git && cd nix-dotfiles
darwin-rebuild switch --flake .#yourname-macbook

# If darwin-rebuild isn't in PATH yet (fresh shell):
/run/current-system/sw/bin/darwin-rebuild switch --flake .#yourname-macbook
```

---

## Ubuntu / Linux Setup

```bash
# 1. Install Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Clone and apply
git clone https://github.com/DennisRotondi/nix-dotfiles.git && cd nix-dotfiles
nix run home-manager -- switch --flake .#yourname

# Subsequent rebuilds
home-manager switch --flake .#yourname

# If unfree packages are needed:
NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake .#yourname --impure

# Set zsh as default shell if needed
chsh -s $(which zsh)
```

> **Docker:** the CLI is installed via Nix but the daemon runs via systemd.
> Enable once with: `sudo systemctl enable --now docker`

### ARM Linux (Raspberry Pi, ARM VM)

Same as above, but use `--flake .#yourname-arm`.

---

## Structure

```
flake.nix              ← username lives here (single source of truth)
modules/
  darwin/              ← macOS system config (nix-darwin only)
    user.nix           ← hostname + user account (derived from username)
    system.nix, defaults.nix, fonts.nix, homebrew.nix
  home/                ← shared config (macOS + Linux)
    user.nix           ← home directory path (platform-aware)
    packages.nix       ← packages (macOS-only gated with lib.optionals)
    programs.nix       ← bat, eza, fzf, git, lazygit, direnv, zoxide
    tmux.nix
    zsh/
      default.nix      ← options, keybindings, plugins, aliases
      .p10k.zsh        ← Powerlevel10k theme → deployed to ~/.p10k.zsh
      plugins.txt      ← antidote plugin list → deployed to ~/.zsh_plugins.txt
      README.md        ← shell reference (keybindings, aliases, functions)
```

---

## Applying Changes

After editing any `.nix` file, rebuild to apply:

**macOS**
```bash
darwin-rebuild switch --flake .#yourname-macbook
```

**Linux**
```bash
home-manager switch --flake .#yourname

# If unfree packages are needed:
NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake .#yourname --impure
```

**ARM Linux**
```bash
home-manager switch --flake .#yourname-arm
```

---

## Troubleshooting

**`nix` not found after install**
```bash
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

**Validate flake without building**
```bash
nix flake show
```

**Check nix-darwin daemon (macOS)**
```bash
launchctl list | grep nix
```
