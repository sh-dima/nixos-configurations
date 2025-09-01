{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.jetbrains-plugins.lib.buildIdeWithPlugins pkgs.jetbrains.idea-community-src (with pkgs.jetbrains-plugins; [
      com.github.deeepamin.gitlabciaid."1.0.5"
      com.demonwav.minecraft-dev."2024.3-1.8.2"
    ]))
  ];
}
