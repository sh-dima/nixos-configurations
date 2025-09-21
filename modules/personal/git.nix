{ config, ... }:

{
  programs.git = {
    userName = "Esoteric Enderman";
    userEmail = "EsotericEnderman@proton.me";

    extraConfig = {
      alias = {
        real = "! git config user.name \"$(cat ${config.sops.secrets."git/username".path})\" && git config user.email $(cat ${config.sops.secrets."git/email".path}) && git profile";
        fake = "! git config user.name \"Esoteric Enderman\" && git config user.email EsotericEnderman@proton.me && git profile";
      };
    };
  };
}
