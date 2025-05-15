{ pkgs, ... }:

{
  enable = true;
  userName = "Sergey Kuleshov";
  userEmail = "sergey@kuleshov.online";
  aliases = {
    publish = "!git push --set-upstream origin $(git symbolic-ref --short HEAD)";
  };

  lfs.enable = true;
  # signing = {
  # };

  delta = {
    enable = true;
    options = {
      navigate = true;
      side-by-side = true;
    };
  };

  extraConfig = {
    core = {
      editor = "code --wait";
      autocrlf = "input";
    };

    pull = {
      rebase = false;
    };

    init = {
      defaultBranch = "main";
    };

    push = {
      autoSetupRemote = true;
    };
  };

  ignores = [
    ".nyc_output"
    "coverage"
    "*.iml"
    ".idea"
    "codesigndoc"
    "codesigndoc_exports"
    ".idea/"
    "scratch.*"
    ".quokka"
    ".run"
    "node_modules*"
    ".DS_Store"
    ".history"
    ".tool-versions"
    ".config/fish/fish_variables*"
    ".aws/sso"
    ".aws/cli"
    ".ssh/known_hosts*"
    ".direnv"
    ".devenv"
    ".envrc"
    "shell.nix"
  ];

}
