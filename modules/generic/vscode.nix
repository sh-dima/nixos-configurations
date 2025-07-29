{ pkgs, ... }:

{
  package = pkgs.vscodium;

  enableUpdateCheck = false;
  enableExtensionUpdateCheck = false;

  extensions = pkgs.nix4vscode.forVscode [
    "jnoortheen.nix-ide.0.4.22"
    "esbenp.prettier-vscode.11.0.0"
    "redhat.vscode-xml.0.29.0"
  ];

  userSettings = {
    "editor.renderWhitespace" = "boundary";

    "redhat.telemetry.enabled" = false;

    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";

    "prettier.useTabs" = true;
    "prettier.printWidth" = 100000;
    "prettier.singleAttributePerLine" = true;
    "prettier.htmlWhitespaceSensitivity" = "strict";

    "xmlTools.splitAttributesOnFormat" = true;
    "prettyxml.settings.positionFirstAttributeOnSameLine" = false;

    "workbench.editorAssociations" = {
      "*.svg" = "default";
    };
  };
}
