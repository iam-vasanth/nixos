{ ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = false;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      command_timeout = 1000;
      add_newline = true;

      # Format configuration - uses terminal colors
      format = "(bold cyan)$username$hostname$directory$git_branch$git_status$git_state$nix_shell$container\n(bold cyan)$character";
      right_format = "$cmd_duration";

      character = {
        success_symbol = "[➠](bold green)";
        error_symbol = "[➠](bold red)";
      };

      username = {
        style_user = "bold blue";
        style_root = "bold red";
        format = "[$user]($style)";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = true;
        format = "@[$hostname](bold purple) ";
        disabled = false;
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        format = " » [$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
        read_only = " 🔒";
        read_only_style = "red";
        home_symbol = "~";
      };

      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold purple";
        truncation_length = 20;
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "bold red";
        conflicted = "🏳";
        up_to_date = "✓";
        untracked = "?";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
        stashed = "📦";
        modified = "!";
        staged = "[++\\($count\\)](green)";
        renamed = "»";
        deleted = "✘";
      };

      git_state = {
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        style = "bold yellow";
      };

      cmd_duration = {
        min_time = 500;
        format = "took [$duration](bold yellow) ";
      };

      nix_shell = {
        format = "via [$symbol$state]($style) ";
        style = "bold blue";
        impure_msg = "impure";
        pure_msg = "pure";
        unknown_msg = "";
      };

      docker_context = {
        format = "via [$symbol$context]($style) ";
        style = "bold blue";
      };

      nodejs = {
        format = "via [$symbol($version )]($style)";
        style = "bold green";
      };

      python = {
        format = "via [\${symbol}\${pyenv_prefix}(\${version} )(\\(\$virtualenv\\) )]($style)";
        style = "bold yellow";
      };

      rust = {
        format = "via [$symbol($version )]($style)";
        style = "bold red";
      };

      golang = {
        format = "via [$symbol($version )]($style)";
        style = "bold cyan";
      };

      java = {
        format = "via [$symbol($version )]($style)";
        style = "bold red";
      };

      package = {
        format = "is [$symbol$version]($style) ";
        style = "bold purple";
      };

      lua = {
        format = "via [$symbol($version )]($style)";
        style = "bold blue";
      };

      c = {
        format = "via [$symbol($version )]($style)";
        style = "bold blue";
      };

      cpp = {
        format = "via [$symbol($version )]($style)";
        style = "bold blue";
      };

      ruby = {
        format = "via [$symbol($version )]($style)";
        style = "bold red";
      };

      php = {
        format = "via [$symbol($version )]($style)";
        style = "bold purple";
      };

      kotlin = {
        format = "via [$symbol($version )]($style)";
        style = "bold purple";
      };

      swift = {
        format = "via [$symbol($version )]($style)";
        style = "bold red";
      };
    };
  };
}
