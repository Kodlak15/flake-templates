{
  description = "Jupyter Notebook template with basic packages for data science.";

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
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            python3
            python3Packages.numpy
            python3Packages.matplotlib
            python3Packages.seaborn
            python3Packages.pandas
            python3Packages.jupyter-core
            python3Packages.notebook
          ];

          shellHook = ''
            exec zsh -c zellij
          '';
        };
      };
    };
}
