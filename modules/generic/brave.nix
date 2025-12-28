{ pkgs, ... }:

{
  home.activation.brave = {
    after = [
      "writeBoundary"
    ];

    before = [
    ];

    data = ''
      mkdir -p /home/dima/.config/BraveSoftware/Brave-Browser/Default/
      ${pkgs.python3}/bin/python ${../../scripts/config/brave/brave.py}
    '';
  };
}
