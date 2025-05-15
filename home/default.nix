{
  config,
  pkgs,
  unstablePkgs,
  inputs,
  ...
}:
let
  dank-mono = import ./dank-mono.nix { inherit pkgs; }; # Import the new module
in
{
  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_edsa" ];

    secrets = {
      hosts = {
        file = ../secrets/ssh-hosts.config;
        path = "${config.home.homeDirectory}/.ssh/hosts.config";
      };
      aws = {
        file = ../secrets/aws.config;
        path = "${config.home.homeDirectory}/.aws/config";
      };
    };
  };

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    silent = true;
  };

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  home.enableNixpkgsReleaseCheck = false;
  home.username = "sergeykuleshov";
  home.homeDirectory = "/Users/sergeykuleshov";
  xdg.enable = true;
  xdg.dataFile."postgresql/.keep".text = "";
  xdg.dataFile."redis/.keep".text = "";
  xdg.dataFile."kafka/.keep".text = "";

  home.stateVersion = "23.11";

  home.packages = [
    dank-mono
  ];

  programs = {
    fish = import ./fish.nix { inherit pkgs; };
    awscli = import ./aws.nix { inherit pkgs; };
    fzf = import ./fzf.nix { inherit pkgs; };
    ssh = import ./ssh.nix { };
    eza = import ./eza.nix { inherit pkgs; };
    zellij = import ./zellij.nix { inherit pkgs; };
    bat = import ./bat.nix { inherit pkgs; };
    git = import ./git.nix { inherit pkgs; };
    aerospace = import ./aerospace.nix { inherit pkgs; };
  };

  # xdg.configFile."zellij/config.kdl".source = ../dotfiles/zellij/config.kdl;

  home = {
    file = {
      ".lima/default/lima.yaml".source = ../assets/lima.yaml;
    };

    sessionVariables = {
      LC_ALL = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      EDITOR = "vim";
    };
    sessionPath = [
      "/usr/local/bin"
    ];
  };
}
