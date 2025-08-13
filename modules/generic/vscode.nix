{ pkgs, ... }:

{
  package = pkgs.vscodium;

  profiles.default.enableUpdateCheck = false;
  profiles.default.enableExtensionUpdateCheck = false;

  profiles.default.extensions = pkgs.nix4vscode.forVscode [
    "mhutchie.git-graph.1.30.0"
    "yandeu.five-server.0.3.9"

    "redhat.java.1.43.1"
    "jnoortheen.nix-ide.0.4.22"
    "supakornras.asymptote.2.1.0"
    "denoland.vscode-deno.3.45.1"
    "esbenp.prettier-vscode.11.0.0"
  ];

  profiles.default.userSettings = {
    "workbench.startupEditor" = "none";

    "editor.renderWhitespace" = "boundary";

    "git.confirmSync" = false;

    "extensions.autoUpdate" = false;

    "redhat.telemetry.enabled" = false;

    "java.jdt.ls.java.home" = pkgs.jdk;

    "java.project.referencedLibraries" = {
      include = [
        "${pkgs.jdk}/**/*.jar"
      ];

      sources = {
        "${builtins.unsafeDiscardStringContext pkgs.jdk}/lib/openjdk/lib/jrt-fs.jar" = "${pkgs.jdk}/lib/openjdk/lib/src.zip";
      };
    };

    "java.compile.nullAnalysis.mode" = "automatic";
    "java.configuration.updateBuildConfiguration" = "automatic";

    "java.symbols.includeSourceMethodDeclarations" = true;

    "java.eclipse.downloadSources" = true;
    "java.maven.downloadSources" = true;

    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";

    "editor.insertSpaces" = false;
    "editor.tabSize" = 2;

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

    "[json]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };

    "[html]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
  };
}
