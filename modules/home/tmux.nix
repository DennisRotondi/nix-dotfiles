{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;

    terminal = "tmux-256color";
    prefix = "C-a";
    mouse = true;
    historyLimit = 100000;
    keyMode = "vi";

    escapeTime = 0;

    extraConfig = ''
      set-option -g default-shell ${pkgs.zsh}/bin/zsh
      set-option -g default-command "${pkgs.zsh}/bin/zsh -l"

      # True color support
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      # Reload config with Prefix + r
      unbind r
      bind r source-file "$XDG_CONFIG_HOME/tmux/tmux.conf" \; display-message "Config reloaded"

      # Split panes
      unbind v
      unbind h
      unbind %
      unbind '"'
      bind v split-window -h -c "#{pane_current_path}"
      bind h split-window -v -c "#{pane_current_path}"

      # Pane navigation (vim-style, no prefix)
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

      # Window management
      unbind n
      unbind w
      bind n command-prompt "rename-window '%%'"
      bind w new-window -c "#{pane_current_path}"
      bind -n M-j previous-window
      bind -n M-k next-window

      # Copy-mode: pipe to macOS clipboard via pbcopy
      unbind -T copy-mode-vi Enter
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
    '';
  };
}
