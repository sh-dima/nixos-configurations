{ pkgs, inputs, ... }:

{
  package = pkgs.librewolf;

  profiles.default = {
    extensions.packages = with inputs.firefox-addons.packages.x86_64-linux; [
      bitwarden
      sponsorblock
      darkreader
    ];

    settings = {
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

      "browser.startup.page" = 3;
    };
  };
}
