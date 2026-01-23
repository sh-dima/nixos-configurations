{ pkgs, ... }:

{
  package = pkgs.vscodium;

  profiles.default.enableUpdateCheck = false;
  profiles.default.enableExtensionUpdateCheck = false;

  profiles.default.extensions = pkgs.nix4vscode.forVscode [
    "PKief.material-icon-theme.5.27.0"

    "mhutchie.git-graph.1.30.0"
    "streetsidesoftware.code-spell-checker.4.2.6"
    "streetsidesoftware.code-spell-checker-german.2.3.4"
    "streetsidesoftware.code-spell-checker-russian.2.2.4"
    "yandeu.five-server.0.3.9"

    "jnoortheen.nix-ide.0.4.22"
    "supakornras.asymptote.2.1.0"
    "denoland.vscode-deno.3.45.1"
    "svelte.svelte-vscode.109.11.2"
    "ms-python.python.2025.4.0"
    "tomoki1207.pdf.1.2.2"
    "ms-edu.pxt-vscode-web.1.0.8"
    "rickvansloten.bbcode.0.0.2"
    "tamasfe.even-better-toml.0.21.2"
    "esbenp.prettier-vscode.11.0.0"
    "James-Yu.latex-workshop"
    "myriad-dreamin.tinymist.0.14.4"
  ];

  profiles.default.userSettings = {
    "workbench.startupEditor" = "none";
    "explorer.confirmDelete" = false;
    "explorer.autoReveal" = false;

    "editor.renderWhitespace" = "boundary";
    "diffEditor.ignoreTrimWhitespace" = false;

    "workbench.iconTheme" = "material-icon-theme";
    "window.menuBarVisibility" = "hidden";

    "editor.fontFamily" = "'Fira Code', 'Droid Sans Mono', 'monospace', monospace";
    "editor.fontLigatures" = true;

    "terminal.integrated.fontFamily" = "'Fira Code'";
    "terminal.integrated.fontLigatures.enabled" = true;

    "terminal.integrated.env.linux" = {
      "GIT_EDITOR" = "codium --wait";
    };

    "git.confirmSync" = false;
    "git.autofetch" = true;

    "extensions.autoUpdate" = false;

    "files.exclude" = {
      "**/.git" = false;

      "**/.idea" = true;

      "**/.venv" = true;
      "**/__pycache__" = true;
      "**/.pytest_cache" = true;
    };

    "search.exclude" = {
      "**/.git" = true;
    };

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

    "python.terminal.activateEnvironment" = false;

    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";

    "svelte.enable-ts-plugin" = true;

    "editor.insertSpaces" = false;
    "editor.tabSize" = 2;

    "cSpell.language" = "en,ru,de";
    "cSpell.diagnosticLevel" = "Hint";

    "markdown.updateLinksOnFileMove.enabled" = "prompt";

    "prettier.useTabs" = true;
    "prettier.printWidth" = 100000;
    "prettier.singleAttributePerLine" = true;
    "prettier.htmlWhitespaceSensitivity" = "strict";

    "xmlTools.splitAttributesOnFormat" = true;
    "prettyxml.settings.positionFirstAttributeOnSameLine" = false;

    "files.associations" = {
      "flake.lock" = "json";
      "LICENSE" = "plaintext";
      "LICENSE-*" = "plaintext";
      "NOTICE" = "plaintext";
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
