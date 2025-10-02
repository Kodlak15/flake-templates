{
  description = "My flake templates";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = let
        # Get a list of all direct sub-directories within the root directory containing a flake.nix
        directories = builtins.attrNames (nixpkgs.lib.filterAttrs (name: _:
          builtins.pathExists (./. + "/${name}/flake.nix"))
        (builtins.readDir ./.));
      in {
        # Create a template for each direct sub-directory containing a flake.nix
        # The name of the template is the name of the associated sub-directory
        templates = builtins.listToAttrs (
          map (name: {
            name = name;
            value = {path = ./. + "/${name}";};
          })
          directories
        );
      };
    };
}
