{
  inputs,
  outputs,
  stateVersion,
  ...
}:
let
  darwin = import ./darwin.nix { inherit inputs outputs stateVersion; };
in
{
  inherit (darwin) mkDarwin;
}
