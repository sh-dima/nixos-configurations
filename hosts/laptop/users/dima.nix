{ inputs, pkgs, ... }:
{
  home.stateVersion = "24.11";

  imports = [
    ../../../modules/generic/git.nix
    ../../../modules/personal/git.nix
    ../modules/personal/git.nix

    ../../../modules/generic/jadx
    ../../../modules/generic/brave.nix
    ../../../modules/generic/scp-sl

    ../../../modules/generic/idea
  ];

  programs = {
    vscode = (import ../../../modules/generic/vscode.nix { inherit pkgs; })
      // { enable = true; };

    plasma = (import ../../../modules/generic/plasma.nix)
      // { enable = true; };
  };

  xdg.mimeApps = (import ../../../modules/generic/xdg.nix)
    // { enable = true; };
}
