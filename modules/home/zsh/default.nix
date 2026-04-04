{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;

    # ── History ───────────────────────────────────────────────────────────────
    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 100000;
      save = 100000;
      extended = true;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };

    # ── Session Variables ─────────────────────────────────────────────────────
    sessionVariables = {
      EDITOR = "code";
      VISUAL = "code";
      CLICOLOR = "1";
      COLORTERM = "truecolor";
      LESS = "-R -F -X";
      LESSHISTFILE = "-";
    };

    # ── PATH ──────────────────────────────────────────────────────────────────
    # (N) glob qualifier: skip silently if directory doesn't exist
    envExtra = ''
      unset ZDOTDIR
      typeset -gU path fpath

      path=(
        $HOME/{,s}bin(N)
        $HOME/.local/{,s}bin(N)
        /opt/{homebrew,local}/{,s}bin(N)
        /usr/local/{,s}bin(N)
        $path
      )
    '';

    initExtra = ''
      # p10k instant prompt — must be first
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # ── Shell Options ───────────────────────────────────────────────────────
      setopt AUTO_CD
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS
      setopt PUSHD_MINUS
      setopt PUSHD_SILENT
      setopt PUSHD_TO_HOME
      setopt CDABLE_VARS
      setopt MULTIOS
      setopt EXTENDED_GLOB
      setopt GLOB_DOTS
      setopt CORRECT
      setopt COMPLETE_IN_WORD
      setopt ALWAYS_TO_END
      setopt PATH_DIRS
      setopt AUTO_MENU
      setopt AUTO_LIST
      setopt AUTO_PARAM_SLASH
      setopt NO_BEEP
      setopt NO_FLOW_CONTROL
      setopt INTERACTIVE_COMMENTS

      # ── Key Bindings ────────────────────────────────────────────────────────
      bindkey -e
      bindkey '^[[1;5C' forward-word       # Ctrl+Right
      bindkey '^[[1;5D' backward-word      # Ctrl+Left
      bindkey '^[[H'    beginning-of-line  # Home
      bindkey '^[[F'    end-of-line        # End
      bindkey '^[[3~'   delete-char        # Delete
      bindkey '^H'      backward-kill-word # Ctrl+Backspace
      bindkey '^[[3;5~' kill-word          # Ctrl+Delete
      bindkey '^P'      up-line-or-search  # Ctrl+P
      bindkey '^N'      down-line-or-search # Ctrl+N

      # ── Directory Stack ─────────────────────────────────────────────────────
      alias d='dirs -v'
      for index ({1..9}) alias "$index"="cd +''${index}"; unset index

      # ── Plugins ─────────────────────────────────────────────────────────────
      source "${pkgs.antidote}/share/antidote/antidote.zsh"
      antidote load

      # ── Completions ─────────────────────────────────────────────────────────
      autoload -Uz compinit
      if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
        compinit
      else
        compinit -C
      fi

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
      zstyle ':completion:*:messages'     format '%F{purple}-- %d --%f'
      zstyle ':completion:*:warnings'     format '%F{red}-- no matches found --%f'
      zstyle ':completion:*:corrections'  format '%F{green}-- %d (errors: %e) --%f'
      zstyle ':completion:*' verbose yes
      zstyle ':completion::complete:*' use-cache on
      zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"

      # ── Syntax Highlighting ─────────────────────────────────────────────────
      typeset -gA FAST_HIGHLIGHT_STYLES
      FAST_HIGHLIGHT_STYLES[default]='none'
      FAST_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
      FAST_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
      FAST_HIGHLIGHT_STYLES[alias]='fg=cyan'
      FAST_HIGHLIGHT_STYLES[builtin]='fg=cyan'
      FAST_HIGHLIGHT_STYLES[function]='fg=cyan'
      FAST_HIGHLIGHT_STYLES[command]='fg=green'
      FAST_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
      FAST_HIGHLIGHT_STYLES[path]='fg=blue'
      FAST_HIGHLIGHT_STYLES[globbing]='fg=magenta'
      FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
      FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'

      # ── Autosuggestions ─────────────────────────────────────────────────────
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
      ZSH_AUTOSUGGEST_USE_ASYNC=1

      # ── fzf-tab ─────────────────────────────────────────────────────────────
      zstyle ':fzf-tab:*' fzf-preview 'eza -1 --color=always $realpath 2>/dev/null || bat --color=always $realpath 2>/dev/null || echo $realpath'
      zstyle ':fzf-tab:*' fzf-flags --preview-window=right:50%:wrap

      # Homebrew (macOS only, no-op elsewhere)
      (( $+commands[brew] )) && eval "$(brew shellenv)"

      # ── Miniconda ───────────────────────────────────────────────────────────
      if [[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]]; then
        source "$HOME/miniconda3/etc/profile.d/conda.sh"
      elif [[ -d "$HOME/miniconda3/bin" ]]; then
        export PATH="$HOME/miniconda3/bin:$PATH"
      fi

      # ── Powerlevel10k ───────────────────────────────────────────────────────
      [[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

      # ── Functions ───────────────────────────────────────────────────────────
      mkcd() { mkdir -p "$1" && cd "$1"; }
      backup() { cp "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}; }

      cdf() {
        local dir
        dir=$(fd --type d | fzf --preview 'eza --tree --level=2 {}') && cd "$dir"
      }

      fe() {
        local file
        file=$(fd --type f | fzf --preview 'bat --color=always {}') && ''${EDITOR} "$file"
      }

      # attach to existing tmux session or create new one
      tm() {
        [[ -n "$TMUX" ]] && { echo "already inside tmux"; return 1; }
        tmux has-session 2>/dev/null && tmux attach-session || tmux new-session
      }
    '';

    # ── Aliases ───────────────────────────────────────────────────────────────
    shellAliases = {
      # navigation
      ".."   = "cd ..";
      "..."  = "cd ../..";
      "...." = "cd ../../..";
      "~"    = "cd ~";
      "-"    = "cd -";

      # listing
      ls  = "eza --color=always --group-directories-first";
      ll  = "eza -l --git --header --color=always --group-directories-first";
      la  = "eza -la --git --header --color=always --group-directories-first";
      lt  = "eza --tree --level=3 --color=always --group-directories-first";
      l   = "eza -lbF --git --color=always --group-directories-first";

      # modern replacements
      cat  = "bat";
      grep = "rg";
      find = "fd";

      # git
      g    = "lazygit";
      gs   = "git status -sb";
      ga   = "git add";
      gc   = "git commit";
      gp   = "git push";
      gl   = "git pull";
      gd   = "git diff";
      gco  = "git checkout";
      gb   = "git branch";
      glog = "git log --oneline --graph --decorate --all";

      # python
      py     = "python3";
      python = "python3";
      pip    = "pip3";

      # misc
      h      = "history";
      q      = "exit";
      c      = "clear";
      v      = "nvim";
      reload = "exec zsh";
      path   = "echo -e \${PATH//:/\\n}";
    };
  };

  # ── Static Files ──────────────────────────────────────────────────────────
  # .p10k.zsh is generated locally via `p10k configure` and not tracked in git
  home.file.".zsh_plugins.txt".source = ./plugins.txt;
}
