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
    bat = import ./bat.nix { inherit pkgs; };
    git = import ./git.nix { inherit pkgs; };
    aerospace = import ./aerospace.nix { inherit pkgs; };
    lazydocker = {
      enable = true;
    };
    lazygit = {
      enable = true;
    };
    btop = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    yazi = {
      enable = true;
      # package = inputs.yazi.packages.${pkgs.system}.default;
      enableFishIntegration = true;
      plugins = {
        git = pkgs.yaziPlugins.git;
        diff = pkgs.yaziPlugins.diff;
        mediainfo = pkgs.yaziPlugins.mediainfo;
        rich-preview = pkgs.yaziPlugins.rich-preview;
        smart-enter = pkgs.yaziPlugins.smart-enter;
        bookmarks = ../assets/yazi/bookmarks.yazi;
      };
      initLua = ''
        require("git"):setup()
        require("bookmarks"):setup({
          last_directory = { enable = false, persist = false, mode="dir" },
          persist = "all",
          desc_format = "full",
          file_pick_mode = "parent",
          custom_desc_input = false,
          notify = {
            enable = true,
            timeout = 1,
            message = {
              new = "New bookmark '<key>' -> '<folder>'",
              delete = "Deleted bookmark in '<key>'",
              delete_all = "Deleted all bookmarks",
            },
          },
        })
      '';
      keymap = {
        manager.prepend_keymap = [
          {
            on = "<Enter>";
            run = "plugin smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = "<C-d>";
            run = "plugin diff";
            desc = "Diff the selected with the hovered file";
          }
          {
            on = [ "m" ];
            run = "plugin bookmarks save";
            desc = "Save current position as a bookmark";
          }
          {
            on = [ "'" ];
            run = "plugin bookmarks jump";
            desc = "Jump to a bookmark";
          }
          {
            on = [
              "b"
              "d"
            ];
            run = "plugin bookmarks delete";
            desc = "Delete a bookmark";
          }
        ];
      };
      settings = {
        plugin.prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
    };
    kitty = {
      enable = true;
      enableGitIntegration = true;
      shellIntegration = {
        enableBashIntegration = true;
        enableFishIntegration = true;
      };
      extraConfig = ''
        shell_integration all

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
        tab_bar_background none

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
        name = "Ubuntu Sans Mono";
        size = 13.5;
      };
    };
  };

  xdg.configFile."process-compose/theme.yaml".source =
    ../assets/process-compose/catppuccin-frappe.yaml;

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
