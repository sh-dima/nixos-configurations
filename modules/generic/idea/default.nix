{
  home.activation.idea = {
    after = [
      "writeBoundary"
    ];

    before = [
    ];

    data = ''
      mkdir -p /home/dima/.config/JetBrains/IdeaIC2025.1/options/
      mkdir -p /home/dima/.config/JetBrains/IdeaIC2025.1/codestyles/

      cat ${./project.default.xml} > /home/dima/.config/JetBrains/IdeaIC2025.1/options/project.default.xml
      cat ${./filetypes.xml} > /home/dima/.config/JetBrains/IdeaIC2025.1/options/filetypes.xml
      cat ${./codestyles/Default.xml} > /home/dima/.config/JetBrains/IdeaIC2025.1/codestyles/Default.xml
    '';
  };
}
