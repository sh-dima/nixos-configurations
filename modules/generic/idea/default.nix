{
  home.activation.idea = {
    after = [
      "writeBoundary"
    ];

    before = [
    ];

    data = ''
      mkdir -p /home/dima/.config/JetBrains/IdeaIC2025.1/options/
      cat ${./project.default.xml} > /home/dima/.config/JetBrains/IdeaIC2025.1/options/project.default.xml
    '';
  };
}
