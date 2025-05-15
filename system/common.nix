{
  inputs,
  outputs,
  config,
  lib,
  hostname,
  system,
  username,
  pkgs,
  unstablePkgs,
  ...
}:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
  # Import the homebrew packages
  homebrewPackages = import ./homebrew-packages.nix;
in
{
  users.users.sergeykuleshov = {
    name = "sergeykuleshov";
    home = "/Users/sergeykuleshov";
    shell = pkgs.fish;
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
    # channel.enable = false;
  };
  system.stateVersion = 5;

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "${system}";
  };

  # fonts.packages = [
  #   (pkgs.nerdfonts.override {
  #     fonts = [
  #       "FiraCode"
  #       "FiraMono"
  #       "Hack"
  #       "JetBrainsMono"
  #     ];
  #   })
  # ];

  # pins to stable as unstable updates very often
  nix.registry = {
    n.to = {
      type = "path";
      path = inputs.nixpkgs;
    };
    u.to = {
      type = "path";
      path = inputs.nixpkgs-unstable;
    };
  };

  nix.settings.trusted-users = [
    "root"
    "sergeykuleshov"
  ];

  programs.nix-index.enable = true;

  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   promptInit = builtins.readFile ./../../data/mac-dot-zshrc;
  # };

  programs.fish.enable = true;

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    global.autoUpdate = true;

    brews = homebrewPackages.brews;
    casks = homebrewPackages.casks;
    masApps = homebrewPackages.masApps;
  };

  # Keyboard
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = false;

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # macOS configuration
  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
  system.defaults = {
    # NSGlobalDomain.AppleShowAllExtensions = true;
    # NSGlobalDomain.NSUseAnimatedFocusRing = false;
    # NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    # NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    # NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    # NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
    # NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    # NSGlobalDomain.ApplePressAndHoldEnabled = false;
    # NSGlobalDomain.InitialKeyRepeat = 25;
    # NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain.NSWindowShouldDragOnGesture = true;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    LaunchServices.LSQuarantine = false; # disables "Are you sure?" for new apps
    loginwindow.GuestEnabled = false;
    # finder.FXPreferredViewStyle = "Nlsv";

    spaces.spans-displays = false;

    dock = {
      # auto show and hide dock
      autohide = true;
      # remove delay for showing dock
      autohide-delay = 0.0;
      # how fast is the dock showing animation
      autohide-time-modifier = 0.5;
      expose-animation-duration = 0.2;
      tilesize = 48;
      launchanim = false;
      static-only = false;
      showhidden = true;
      show-recents = false;
      show-process-indicators = true;
      orientation = "bottom";
      mru-spaces = false;
      # mouse in top right corner will (5) start screensaver
      wvous-tl-corner = 5;
    };
  };

  system.defaults.CustomUserPreferences = {
    "com.apple.finder" = {
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = true;
      _FXSortFoldersFirst = true;
      #     # When performing a search, search the current folder by default
      #     FXDefaultSearchScope = "SCcf";
      #     DisableAllAnimations = true;
      NewWindowTarget = "PfDe";
      NewWindowTargetPath = "file://$\{HOME\}/";
      #     AppleShowAllExtensions = true;
      #     FXEnableExtensionChangeWarning = false;
      ShowStatusBar = true;
      ShowPathbar = true;
      WarnOnEmptyTrash = false;
    };
    "com.apple.desktopservices" = {
      # Avoid creating .DS_Store files on network or USB volumes
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "com.apple.ActivityMonitor" = {
      OpenMainWindow = true;
      IconType = 5;
      SortColumn = "CPUUsage";
      SortDirection = 0;
    };
    "com.apple.AdLib" = {
      allowApplePersonalizedAdvertising = false;
    };
    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;
      # Check for software updates daily, not just once per week
      ScheduleFrequency = 1;
      # Download newly available updates in background
      AutomaticDownload = 1;
      # Install System data files & security updates
      # CriticalUpdateInstall = 1;
    };
    "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
    #   # Prevent Photos from opening automatically when devices are plugged in
    #   "com.apple.ImageCapture".disableHotPlug = true;
    #   # Turn on app auto-update
    #   "com.apple.commerce".AutoUpdate = true;
    #   "com.googlecode.iterm2".PromptOnQuit = false;
    #   "com.google.Chrome" = {
    #     AppleEnableSwipeNavigateWithScrolls = true;
    #     DisablePrintPreview = true;
    #     PMPrintingExpandedStateForPrint2 = true;
    #   };
  };

  services.dnsmasq.enable = true;
  environment.etc."dnsmasq.conf".text = ''
    address=/.orb.stack/127.0.0.1
    listen-address=127.0.0.1
  '';
  environment.etc."resolver/orb.stack".text = ''
    nameserver 127.0.0.1
  '';

}
