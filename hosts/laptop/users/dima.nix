{ inputs, pkgs, ... }:

{
  home.stateVersion = "24.11";

  programs = {
    git = (import ../../../modules/generic/git.nix)
      // (import ../../../modules/personal/git.nix)
      // { enable = true; };

    vscode = (import ../../../modules/generic/vscode.nix { inherit pkgs; })
      // { enable = true; };

    librewolf = (import ../../../modules/generic/librewolf.nix {inherit pkgs inputs; })
      // { enable = true; };

    plasma = (import ../../../modules/generic/plasma.nix)
      // { enable = true; };
  };

  xdg.mimeApps = (import ../../../modules/generic/xdg.nix)
    // { enable = true; };
}
