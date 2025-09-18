{
  description = "SvelteKit template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShells = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nodejs
            nodePackages.typescript
            pm2
            postgresql_16
          ];

          shellHook = ''
            exec zsh -c zellij
          '';
        };
      };
    });
}
