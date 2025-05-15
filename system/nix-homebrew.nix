{ inputs, system, username, ... }:

{
  # Import the necessary nix-homebrew darwin module.
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  # Configure nix-homebrew settings
  nix-homebrew = {
    enable = true;
    mutableTaps = false;
    user = username;
    taps = with inputs; {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
    };
  };
}