{ pkgs, ... }:

{
  package = pkgs.vscodium;

  extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
    esbenp.prettier-vscode
    dotjoshjohnson.xml
  ];

  userSettings = {
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";

    "prettier.useTabs" = true;

    "xmlTools.splitAttributesOnFormat" = true;

    "workbench.editorAssociations" = {
      "*.svg" = "default";
    };
  };
}
