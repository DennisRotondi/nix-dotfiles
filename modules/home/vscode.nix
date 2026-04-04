{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    userSettings = {
      "workbench.colorTheme"    = "Atom One Dark";
      "workbench.iconTheme"     = "material-icon-theme";
      "editor.fontFamily"       = "'JetBrains Mono', Consolas, monospace";
      "editor.fontSize"         = 14;
      "editor.lineHeight"       = 1.6;
      "editor.tabSize"          = 2;
      "editor.insertSpaces"     = true;
      "editor.detectIndentation" = false;
      "editor.renderWhitespace" = "all";
      "editor.minimap.enabled"  = false;
      "editor.wordWrap"         = "wordWrapColumn";
      "editor.wordWrapColumn"   = 100;

      "notebook.formatOnSave.enabled" = true;

      "[python]" = {
        "editor.formatOnSave"     = true;
        "editor.defaultFormatter" = "charliermarsh.ruff";
        "editor.codeActionsOnSave" = {
          "source.fixAll.ruff" = "explicit";
        };
      };

      "git.autofetch" = true;

      "workbench.activityBar.location"           = "hidden";
      "workbench.editor.enablePreview"           = true;
      "workbench.editor.enablePreviewFromQuickOpen" = true;
      "workbench.editor.revealIfOpen"            = true;

      "terminal.integrated.inheritEnv" = true;
      "terminal.integrated.env.osx" = {
        "PATH" = "\${env:HOME}/.nix-profile/bin:/usr/bin:\${env:PATH}";
      };
      "terminal.integrated.env.linux" = {
        "PATH" = "\${env:HOME}/.nix-profile/bin:/usr/bin:\${env:PATH}";
      };
      "terminal.integrated.profiles.osx" = {
        "zsh" = {
          "path" = "env";
          "args" = [ "zsh" ];
        };
      };
      "terminal.integrated.defaultProfile.osx" = "zsh";
      "terminal.integrated.profiles.linux" = {
        "zsh" = {
          "path" = "zsh";
        };
      };
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "claudeCode.preferredLocation" = "panel";

      "vim.easymotion"        = true;
      "vim.incsearch"         = true;
      "vim.useSystemClipboard" = true;
      "vim.useCtrlKeys"       = true;
      "vim.hlsearch"          = true;
      "vim.leader"            = "<space>";
      "vim.handleKeys" = {
        "<C-a>" = false;
        "<C-f>" = false;
      };
      "vim.insertModeKeyBindings" = [
        { "before" = [ "j" "j" ]; "after" = [ "<Esc>" ]; }
      ];
      "vim.normalModeKeyBindingsNonRecursive" = [
        { "before" = [ "<leader>" "d" ]; "after" = [ "d" "d" ]; }
        { "before" = [ "<C-n>" ]; "commands" = [ ":nohl" ]; }
        { "before" = [ "K" ]; "commands" = [ "lineBreakInsert" ]; "silent" = true; }
      ];
      # Dedicate a separate process to vim extension for better performance
      "extensions.experimental.affinity" = {
        "vscodevim.vim" = 1;
      };

      "explorer.confirmDragAndDrop"                     = false;
      "markdown-preview-enhanced.enablePreviewZenMode"  = true;
      "security.workspace.trust.untrustedFiles"         = "open";
    };

    keybindings = [
      { key = "cmd+alt+t"; command = "workbench.action.terminal.new"; }
      { key = "cmd+alt+w"; command = "workbench.action.terminal.kill"; }
      { key = "cmd+alt+l"; command = "workbench.action.terminal.focusNext"; }
      { key = "cmd+alt+h"; command = "workbench.action.terminal.focusPrevious"; }
      { key = "cmd+alt+`"; command = "workbench.action.terminal.toggleTerminal"; }
      {
        key     = "shift+cmd+9";
        command = "workbench.action.terminal.split";
        when    = "terminalFocus && terminalProcessSupported || terminalFocus && terminalWebExtensionContributedProfile";
      }
      # Unbind cmd+\ from all terminal/editor split actions
      {
        key     = "cmd+\\";
        command = "-workbench.action.terminal.split";
        when    = "terminalFocus && terminalProcessSupported || terminalFocus && terminalWebExtensionContributedProfile";
      }
      {
        key     = "cmd+\\";
        command = "-workbench.action.splitEditor";
      }
      {
        key     = "cmd+\\";
        command = "-workbench.action.terminal.splitActiveTab";
        when    = "terminalProcessSupported && terminalTabsFocus";
      }
    ];
  };
}
