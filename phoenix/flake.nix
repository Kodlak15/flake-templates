{
  description = "Phoenix web development template";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        devShells.default = import ./nix/shells/default.nix {inherit pkgs;};

        packages = {
          app-local-init = pkgs.writeShellScriptBin "app-local-init" ''
            mix phx.server
          '';
          db-local-up = pkgs.writeShellScriptBin "db-local-up" ''
            ${pkgs.docker}/bin/docker compose up db
          '';
          db-local-down = pkgs.writeShellScriptBin "db-local-down" ''
            ${pkgs.docker}/bin/docker compose down db
          '';
        };
      };
    };
}
