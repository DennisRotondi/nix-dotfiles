{ pkgs, ... }: {
  # ── Compatibility ──────────────────────────────────────────────────────────
  # Check `darwin-rebuild changelog` before incrementing this.
  system.stateVersion = 5;

  # ── Nixpkgs ────────────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

  # ── Nix Daemon & Flakes ────────────────────────────────────────────────────
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # ── Nix Garbage Collection ────────────────────────────────────────────────
  nix.gc = {
    automatic = true;
    interval   = { Weekday = 7; Hour = 3; Minute = 0; }; # weekly, Sunday 3am
    options    = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true; # deduplicate store paths

  # ── Shell ──────────────────────────────────────────────────────────────────
  # Must be enabled at the system level so zsh is a valid login shell.
  programs.zsh.enable = true;

  # ── System Packages ────────────────────────────────────────────────────────
  # Keep this minimal — user-level packages live in modules/home/packages.nix
  environment.systemPackages = with pkgs; [
    curl
    git
    wget
  ];
}
