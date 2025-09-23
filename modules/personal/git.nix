{ config, ... }:

{
  programs.git = {
    userName = "Dima FYI";
    userEmail = "DimaFYI@proton.me";

    extraConfig = {
      alias = {
        real = "! git config user.name \"$(cat ${config.sops.secrets."git/username".path})\" && git config user.email $(cat ${config.sops.secrets."git/email".path}) && git profile";
        fake = "! git config user.name \"Dima FYI\" && git config user.email DimaFYI@proton.me && git profile";
      };
    };
  };
}
