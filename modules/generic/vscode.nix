{ pkgs, ... }:

{
  package = pkgs.vscodium;

  enableUpdateCheck = false;
  enableExtensionUpdateCheck = false;

  extensions = pkgs.nix4vscode.forVscode [
    "jnoortheen.nix-ide.0.4.22"
    "esbenp.prettier-vscode.11.0.0"
  ];

  userSettings = {
    "workbench.startupEditor" = "none";

    "editor.renderWhitespace" = "boundary";

    "git.confirmSync" = false;

    "extensions.autoUpdate" = false;

    "redhat.telemetry.enabled" = false;

    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";

    "prettier.useTabs" = true;
    "prettier.printWidth" = 100000;
    "prettier.singleAttributePerLine" = true;
    "prettier.htmlWhitespaceSensitivity" = "strict";

    "xmlTools.splitAttributesOnFormat" = true;
    "prettyxml.settings.positionFirstAttributeOnSameLine" = false;

    "files.associations" = {
      "flake.lock" = "json";
    };

    "workbench.editorAssociations" = {
      "*.svg" = "default";
    };
  };
}
