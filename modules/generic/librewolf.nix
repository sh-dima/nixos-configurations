{ pkgs, inputs, ... }:

{
  package = pkgs.librewolf;

  profiles.default = {
    extensions = with inputs.firefox-addons.packages.x86_64-linux; [
      bitwarden
      sponsorblock
    ];

    settings = {
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

      "browser.startup.page" = 3;
    };
  };
}
