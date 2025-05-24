{pkgs, ...}: {
  enable = true;

  shellAliases = {
    vim = "nvim";
    less = "bat";
  };

  shellAbbrs = {
    gp = "git push";
    gss = "git status -s";
  };
  plugins = [
    {
      name = "fzf";
      src = pkgs.fishPlugins.fzf-fish.src;
    }
    {
      name = "done";
      src = pkgs.fishPlugins.done.src;
    }
    {
      name = "forgit";
      src = pkgs.fishPlugins.forgit.src;
    }
    {
      name = "hydro";
      src = pkgs.fishPlugins.hydro.src;
    }
    {
      name = "fish-nx";
      src = pkgs.fetchFromGitHub {
        owner = "jukben";
        repo = "fish-nx";
        rev = "8c7ed24";
        sha256 = "sha256-3/E+EJZU1TS9SDBRZn1r++6eI7PHjCJpwCbhM59werw=";
      };
    }
  ];

  interactiveShellInit = ''
    set fish_greeting # Disable greeting
    set fish_color_valid_path
    set hydro_symbol_git_dirty ' ●'
    set hydro_color_pwd green
    #set hydro_color_git yellow
    #set fish_prompt_pwd_dir_length 50 # maximum length of dir path
    fzf_configure_bindings

    if status is-interactive
      limactl completion fish | source
    else
      # pass
    end

    function update_prompt --on-variable AWS_PROFILE --on-variable AWS_REGION --on-variable GREET
      set -l components

      if set -q GREET
        set -a components (set_color blue)"$GREET"(set_color normal)
      end

      if set -q AWS_PROFILE
        set -l region (aws configure get region --profile $AWS_PROFILE)
        set -a components (set_color yellow) " $AWS_PROFILE"(set_color normal)
      end

      set -l prefix (string join " " $components)
      set -xg hydro_symbol_start "$prefix "
    end
  '';
}
