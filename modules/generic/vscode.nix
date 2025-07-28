{ pkgs, ... }:

{
  package = pkgs.vscodium;

  extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
    esbenp.prettier-vscode
  ];

  userSettings = {
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";

    "prettier.useTabs" = true;

    "workbench.editorAssociations" = {
      "*.svg" = "default";
    };
  };
}
