{ pkgs, ... }: {
  # macOS native fonts are preferred for best system integration.
  # Apple fonts (SF Mono, SF Pro) are installed via Homebrew (see homebrew.nix).
  fonts.packages = with pkgs; [
    # Best open-source programming fonts for macOS
    jetbrains-mono              # Clean, modern monospace font
    fira-code                   # Popular font with programming ligatures
    source-code-pro             # Adobe's monospace font
  ];
}
