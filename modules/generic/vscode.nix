{ pkgs, ... }:

{
  package = pkgs.vscodium;

  extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
    esbenp.prettier-vscode
    redhat.vscode-xml
  ];

  userSettings = {
    "redhat.telemetry.enabled" = false;

    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";

    "prettier.useTabs" = true;

    "xmlTools.splitAttributesOnFormat" = true;

    "workbench.editorAssociations" = {
      "*.svg" = "default";
    };
  };
}
