{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    # shell utilities
    bat eza ripgrep fd fzf
    jq yq wget curl
    htop btop tree
    delta duf dust procs tldr
    zoxide direnv entr
    sd choose tokei hyperfine difftastic
    glow        # markdown renderer for the terminal
    neovim      # modal editor (used by `v` alias in zsh)

    # development
    gsl llvm boost

    # tex
    # scheme-medium covers most use cases; switch to scheme-full (~5 GB) if needed
    (texlive.combine { inherit (texlive) scheme-medium; })
    texlab

    # containers
    docker docker-compose

    # git
    lazygit

    # zsh plugin manager
    antidote

  ] ++ lib.optionals stdenv.isDarwin [
    # macOS-only
    mas                         # Mac App Store CLI
    reattach-to-user-namespace  # clipboard bridge for tmux
    switchaudio-osx             # audio device switcher
    colima                      # Docker VM runtime
  ];
}
