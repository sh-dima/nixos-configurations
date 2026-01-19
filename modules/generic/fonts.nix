{ pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
    ];
  };
}
