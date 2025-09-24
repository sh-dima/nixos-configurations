{
  home.activation.jadx = {
    after = [
      "writeBoundary"
    ];

    before = [
    ];

    data = ''
      mkdir -p /home/dima/.config/jadx/
      cat ${./gui.json} > /home/dima/.config/jadx/gui.json
    '';
  };
}
