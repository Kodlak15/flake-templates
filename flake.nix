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
        # Get all of the directories within the current directory containing a flake.nix
        directories = builtins.attrNames (nixpkgs.lib.filterAttrs (k: v:
          builtins.pathExists (./. + "/${k}/flake.nix"))
        (builtins.readDir ./.));
      in {
        templates = builtins.listToAttrs (
          map (dir: {
            name = dir;
            value = {path = ./. + "/${dir}";};
          })
          directories
        );
      };
    };
}
