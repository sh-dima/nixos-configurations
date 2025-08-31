{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.jetbrains-plugins.lib.buildIdeWithPlugins pkgs.jetbrains.idea-community-src (with pkgs.jetbrains-plugins; [
      com.github.deeepamin.gitlabciaid."1.0.5"
    ]))
  ];
}
