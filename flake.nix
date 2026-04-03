{
  # ─────────────────────────────────────────────────────────────────────────────
  # Cross-platform dotfiles — nix-darwin (macOS) + home-manager (Linux)
  #
  # To use with a different username, change the single line below.
  # Everything else (home directory, hostname, user account) is derived from it.
  # ─────────────────────────────────────────────────────────────────────────────

  description = "Cross-platform dotfiles — nix-darwin (macOS) + home-manager (Linux)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager }:
  let
    username = "dennis"; # ← change only this
  in {

    # ── macOS (nix-darwin + home-manager) ──────────────────────────────────────
    darwinConfigurations."${username}-macbook" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # change to "x86_64-darwin" for Intel Mac
      specialArgs = { inherit username; };
      modules = [
        ./modules/darwin
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit username; };
          home-manager.users.${username} = import ./modules/home;
        }
      ];
    };

    # ── Linux / Ubuntu x86_64 (standalone home-manager) ────────────────────────
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = { inherit username; };
      modules = [ ./modules/home ];
    };

    # ── Linux ARM (Raspberry Pi, ARM VM) ───────────────────────────────────────
    homeConfigurations."${username}-arm" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."aarch64-linux";
      extraSpecialArgs = { inherit username; };
      modules = [ ./modules/home ];
    };
  };
}
