{ pkgs, ... }:

{
  package = pkgs.vscodium;

  enableUpdateCheck = false;
  enableExtensionUpdateCheck = false;

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
    "prettier.printWidth" = 100000;
    "prettier.singleAttributePerLine" = true;
    "prettier.htmlWhitespaceSensitivity" = "strict";

    "xmlTools.splitAttributesOnFormat" = true;

    "workbench.editorAssociations" = {
      "*.svg" = "default";
    };
  };
}
