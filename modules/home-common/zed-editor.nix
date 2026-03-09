{ ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "discord-presence"
      "html"
      "toml"
      "nix"
      "coloredzediconstheme"
    ];

    userSettings = {
      # Vim mode
      vim_mode = false;

      # Themes
      theme = {
        mode = "dark";
        light = "Noctalia Light";
        dark = "Noctalia Dark";
      };

      # Icon theme
      icon_theme = {
        mode = "dark";
        light = "Colored Zed Icons Theme Light";
        dark = "Colored Zed Icons Theme Dark";
      };

      # Fonts and sizes
      ui_font_size = 16.0;
      ui_font_family = "Inter Nerd Font";
      ui_font_weight = 500.0;

      buffer_font_size = 14;
      buffer_font_family = "JetBrainsMono Nerd Font Mono";
      buffer_font_weight = 300.0;
      buffer_line_height = { custom = 1.5; };

      # Terminal
      terminal = {
        shell.program = "fish";
        font_family = "JetBrainsMono Nerd Font Mono";
        font_size = 14;
        line_height = { custom = 1.4; };
        blinking = "off";
      };

      # Prettier
      prettier.allowed = true;

      # Editor behavior
      relative_line_numbers = "enabled";
      cursor_blink = false;
      show_whitespaces = "selection";
      tab_size = 2;
      soft_wrap = "none";
      format_on_save = "on";
      autosave = "on_focus_change";
      auto_update = false;
      base_keymap = "VSCode";

      # UI preferences
      scrollbar.show = "always";

      toolbar = {
        breadcrumbs = true;
        quick_actions = true;
      };

      tabs = {
        file_icons = true;
        git_status = true;
      };

      # Git
      git = {
        git_gutter = "tracked_files";
        inline_blame.enabled = true;
      };

      # LSP configurations
      lsp = {
        rust-analyzer = {
          binary = {
            path = "rust-analyzer";
            arguments = [];
          };
          initialization_options = {
            check.command = "clippy";
            cargo.allFeatures = true;
            procMacro.enable = true;
          };
        };

        pyright.settings.python.analysis = {
          typeCheckingMode = "basic";
          autoSearchPaths = true;
          useLibraryCodeForTypes = true;
        };

        bash-language-server.initialization_options.bashIde.globPattern = "**/*@(.sh|.inc|.bash|.command)";

        vscode-json-language-server.initialization_options.provideFormatter = true;

        nixd.binary.path_lookup = true;

        taplo.initialization_options.formatter.alignEntries = true;
      };

      show_edit_predictions = true;

      inlay_hints.enabled = true;

      # Language-specific
      languages = {
        JavaScript = {
          tab_size = 2;
          formatter = "prettier";
        };
        TypeScript = {
          tab_size = 2;
          formatter = "prettier";
        };
        Python = {
          tab_size = 4;
          format_on_save = "on";
          formatter = "language_server";
        };
        Rust = {
          tab_size = 4;
          format_on_save = "on";
          formatter = "language_server";
        };
        Go = {
          tab_size = 4;
          format_on_save = "on";
        };
        Bash = {
          tab_size = 2;
          format_on_save = "on";
        };
        JSON = {
          tab_size = 2;
          format_on_save = "on";
          formatter = "language_server";
        };
        TOML = {
          tab_size = 2;
          format_on_save = "on";
          formatter = "language_server";
        };
        Nix = {
          tab_size = 2;
          format_on_save = "on";
          formatter = "language_server";
          language_servers = [ "nixd" "!nil" ];
        };
      };

      # File handling
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save = true;

      # Panels
      collaboration_panel.dock = "right";
      project_panel = {
        dock = "left";
        default_width = 240;
        entry_spacing = "standard";
      };

      # Telemetry
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      edit_predictions.enabled_in_text_threads = false;

      minimap.show = "never";

      # AI (disabled)
      agent = {
        single_file_review = false;
        model_parameters = [];
        enable_feedback = false;
      };
    };
  };
}
