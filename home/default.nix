{
  config,
  pkgs,
  unstablePkgs,
  inputs,
  ...
}: let
  dank-mono = import ./dank-mono.nix {inherit pkgs;}; # Import the new module
in {
  age = {
    identityPaths = ["${config.home.homeDirectory}/.ssh/id_edsa"];

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
    fish = import ./fish.nix {inherit pkgs;};
    awscli = import ./aws.nix {inherit pkgs;};
    fzf = import ./fzf.nix {inherit pkgs;};
    ssh = import ./ssh.nix {};
    eza = import ./eza.nix {inherit pkgs;};
    bat = import ./bat.nix {inherit pkgs;};
    git = import ./git.nix {inherit pkgs;};
    aerospace = import ./aerospace.nix {inherit pkgs;};

    kitty = {
      enable = true;
      enableGitIntegration = true;
      extraConfig = ''
        text_composition_strategy legacy
        window_padding_width 8
        modify_font cell_height 12px
        tab_bar_style powerline
        tab_powerline_style slanted
        tab_bar_edge top
        macos_option_as_alt yes

        # background_opacity 0.9
        # background_blur 40
        macos_titlebar_color background


        tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{tab.last_focused_progress_percent}({index}) {title}"

        # Nerd Fonts v3.3.0
        symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b7,U+e700-U+e8ef,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f381,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font
      '';
      keybindings = {
        "cmd+1" = "goto_tab 1";
        "cmd+2" = "goto_tab 2";
        "cmd+3" = "goto_tab 3";
        "cmd+4" = "goto_tab 4";
        "cmd+5" = "goto_tab 5";
        "cmd+6" = "goto_tab 6";
        "cmd+7" = "goto_tab 7";
        "cmd+8" = "goto_tab 8";
        "cmd+9" = "goto_tab 9";
      };
      darwinLaunchOptions = [
        "--single-instance"
        "--directory=/tmp/my-dir"
        "--listen-on=unix:/tmp/my-socket"
      ];
      font = {
        name = "Ubuntu Mono";
        size = 14;
      };
    };
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
