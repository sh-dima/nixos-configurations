{ username, ... }:

{
  home-manager.users.${username}.programs.git = {
    userName = "Esoteric Enderman";
    userEmail = "EsotericEnderman@proton.me";
  };
}
