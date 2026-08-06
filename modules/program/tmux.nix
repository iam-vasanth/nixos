{
  config,
  lib,
  pkgs,
  unstable,
  ...
}: {
  ###########################################################################
  # Tmux
  ###########################################################################

  options.program.tmux.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.program.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 10000;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      terminal = "tmux-256color";

      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        vim-tmux-navigator
        prefix-highlight
        resurrect
        continuum
      ];

      extraConfig = ''
        set -g default-shell "${pkgs.fish}/bin/fish"
        set -g default-command "${pkgs.fish}/bin/fish"

        # Prefix
        unbind C-b
        set -g prefix C-a
        bind C-a send-prefix

        set -g mouse on
        setw -g pane-base-index 1
        set -g renumber-windows on
        set -g focus-events on
        set-option -sa terminal-overrides ",xterm*:Tc"

        # Vi copy mode
        bind -T copy-mode-vi v send -X begin-selection
        bind -T copy-mode-vi y send -X copy-selection-and-cancel

        # Splits (keep cwd)
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        unbind '"'
        unbind %

        # Resize
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5

        # Reload
        bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded"

        # Resurrect / continuum
        set -g @resurrect-strategy-nvim 'session'
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '15'

        # Status bar
        set -g status-position top
        set -g status-style bg=#131316,fg=#bdc2ff
        set -g status-left ""
        set -g status-right "#{prefix_highlight} #[fg=#bdc2ff]%H:%M "
        set -g window-status-current-format " #[fg=#bdc2ff,bold]#I:#W "
        set -g window-status-format " #[fg=#808080]#I:#W "
        set -g pane-border-style fg=#131316
        set -g pane-active-border-style fg=#bdc2ff
      '';
    };
  };
}
