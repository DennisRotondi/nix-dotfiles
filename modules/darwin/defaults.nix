{ ... }: {
  # ── Dock ──────────────────────────────────────────────────────────────────
  system.defaults.dock.autohide = true;
  system.defaults.dock."mru-spaces" = false; # Keep Spaces in fixed order

  # ── Finder ────────────────────────────────────────────────────────────────
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.finder.FXDefaultSearchScope = "SCcf";       # Search current folder by default
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";       # List view
  system.defaults.finder.ShowExternalHardDrivesOnDesktop = false;
  system.defaults.finder.ShowHardDrivesOnDesktop = false;
  system.defaults.finder.ShowMountedServersOnDesktop = false;
  system.defaults.finder.ShowRemovableMediaOnDesktop = false;
  system.defaults.finder.ShowStatusBar = false;
  system.defaults.finder._FXShowPosixPathInTitle = true;

  # ── Screenshots ───────────────────────────────────────────────────────────
  system.defaults.screencapture.location = "~/Desktop";
  system.defaults.screencapture.disable-shadow = true;
  system.defaults.screencapture.type = "png";

  # ── Keyboard ──────────────────────────────────────────────────────────────
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15; # 225ms before repeat starts
  system.defaults.NSGlobalDomain.KeyRepeat        = 2;  # 30ms between repeats (fast)

  # ── Global Domain ─────────────────────────────────────────────────────────
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;         # Classic scroll

  # ── Custom Preferences ────────────────────────────────────────────────────
  # For keys not covered by nix-darwin's typed options.
  system.defaults.CustomUserPreferences = {
    "com.apple.NetworkBrowser" = {
      BrowseAllInterfaces = 1; # Show all interfaces in network browser
    };
    "com.apple.desktopservices" = {
      DSDontWriteNetworkStores = true; # No .DS_Store on network shares
    };
    "com.apple.spaces" = {
      "spans-displays" = false; # Separate Spaces per display
    };
    "com.apple.LaunchServices" = {
      LSQuarantine = false; # Suppress "downloaded from internet" prompts
    };
    "com.apple.TimeMachine" = {
      DoNotOfferNewDisksForBackup = true;
    };
    "com.apple.mail" = {
      AddressesIncludeNameOnPasteboard = false; # Copy address only, not display name
    };
    NSGlobalDomain = {
      AppleAccentColor = 1;               # Blue
      NSWindowShouldDragOnGesture = true; # Drag windows by clicking anywhere
    };
  };
}
