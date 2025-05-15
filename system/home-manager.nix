{
  inputs,
  hostname,
  username,
  system,
  unstablePkgs,
  ...
}: # Add unstablePkgs here

{

  # Import the necessary home-manager darwin module.
  # This allows the options below to be recognized within the darwinSystem evaluation.
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  # Configure home-manager settings
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs unstablePkgs; }; # Add unstablePkgs here
    users.${username} = {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
        inputs.agenix.homeManagerModules.default
        ../home
      ];
    };
    # sharedModules = [ inputs.nixvim.homeManagerModules.nixvim ]; # Uncommenting this line to include shared modules
  };

  # networking.hostName = hostname; # This is usually set elsewhere (e.g., common.nix or directly in darwin.nix)
}
