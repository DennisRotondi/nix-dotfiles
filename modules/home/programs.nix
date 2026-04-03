{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
      italic-text = "always";
      style = "numbers,changes,header";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "never";
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--color=always"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--inline-info"
      "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
    colors = {
      bg      = "#1e1e2e";
      "bg+"   = "#313244";
      fg      = "#cdd6f4";
      "fg+"   = "#cdd6f4";
      header  = "#f38ba8";
      hl      = "#f9e2af";
      "hl+"   = "#f9e2af";
      info    = "#cba6f7";
      marker  = "#f5e0dc";
      pointer = "#f5e0dc";
      prompt  = "#cba6f7";
      spinner = "#f5e0dc";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        activeBorderColor   = ["#f9e2af" "bold"];
        inactiveBorderColor = ["#a6adc8"];
        selectedLineBgColor = ["#313244"];
      };
      git.paging = {
        colorArg = "always";
        pager    = "delta --dark --paging=never";
      };
    };
  };

  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        navigate     = true;
        line-numbers = true;
        syntax-theme = "Catppuccin Mocha";
        side-by-side = true;
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
