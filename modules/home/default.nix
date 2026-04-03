{ ... }: {
  imports = [
    ./user.nix
    ./packages.nix
    ./programs.nix
    ./tmux.nix
    ./vscode.nix
    ./zsh
  ];

  # Must match the home-manager release
  home.stateVersion = "24.11";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Enable XDG base directories
  xdg.enable = true;
}
