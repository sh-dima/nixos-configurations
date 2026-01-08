{
  home.activation.scp-sl = {
    after = [
      "writeBoundary"
    ];

    before = [
    ];

    data = ''
      mkdir -p "/home/dima/.local/share/Steam/steamapps/compatdata/700330/pfx/drive_c/users/steamuser/AppData/Roaming/SCP Secret Laboratory/"
      cat ${./registry.txt} > "/home/dima/.local/share/Steam/steamapps/compatdata/700330/pfx/drive_c/users/steamuser/AppData/Roaming/SCP Secret Laboratory/registry.txt"
    '';
  };
}
