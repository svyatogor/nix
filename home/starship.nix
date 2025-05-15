{ ... }: {
  enable = false;
  # enableTransience = true;

  # Configuration written to ~/.config/starship.toml
  settings = {
    package = {
      disabled = true;
    };

    cmd_duration = {
      disabled = true;
    };

    aws = {
      symbol = "  ";
      force_display = true;
      region_aliases = {
        eu-central-1 = "eu";
        eu-west-1 = "ie";
        us-east-1 = "us";
      };
    };

    memory_usage = {
      threshold = -1;
      symbol = "🐏 ";
      style = "bold dimmed green";
    };

    battery = {
      display = [{
        threshold = 0;
        style = "bold red";
      }];
    };

    git_branch = {
      symbol = " ";
      truncation_length = 16;
    };

    git_metrics = {
      added_style = "bold blue";
      format = "[ +$added ] ($added_style)/[ -$deleted ] ($deleted_style) ";
      disabled = false;
    };

    # git_status = {
    #   ahead = "⇡${count}";
    #   diverged = "⇕⇡${ahead_count}⇣${behind_count}";
    #   behind = "⇣${count}";
    #   style = "bold blue";
    # };

    java = {
      symbol = " ";
    };

    python = {
      symbol = " ";
    };

    sudo = {
      disabled = false;
    };

    container = {
      disabled = true;
    };
  };
}
