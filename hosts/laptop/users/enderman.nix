{ inputs, pkgs }:

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
  };
}
