{ ... }: {
  # nix-darwin manages Homebrew brews/casks declaratively.
  # Homebrew itself must be installed manually before the first `darwin-rebuild switch`:
  #   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap"; # Remove any brew/cask not listed here
    };

    brews = [
      # Add any brew formulae not available in nixpkgs here
    ];

    casks = [
      # Apple proprietary — not available in nixpkgs
      "sf-symbols"   # SF Symbols icon catalog app
      "font-sf-mono" # SF Mono (used by Terminal / editors)
      "font-sf-pro"  # SF Pro system font
    ];
  };
}
