{pkgs, ...}:
pkgs.mkShell {
  packages = with pkgs; [
    beamMinimal28Packages.elixir
    inotify-tools
    postgresql
  ];

  shellHook = ''
    exec zsh -c zellij
  '';
}
