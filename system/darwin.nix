{
  inputs,
  outputs,
  stateVersion,
  ...
}: {
  mkDarwin = {
    hostname,
    username ? "alex",
    system ? "aarch64-darwin",
  }: let
    inherit (inputs.nixpkgs) lib;
    unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
  in
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit
          system
          inputs
          username
          unstablePkgs
          ;
      };
      #extraSpecialArgs = { inherit inputs; }
      modules = [
        (
          {config, ...}: {
            homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
          }
        )
        ./packages.nix
        ./common.nix
        ./home-manager.nix
        ./nix-homebrew.nix
        ./vim.nix
      ];
    };
}
