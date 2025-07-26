{ username, ... }:

{
  home-manager.users.${username}.programs.git = {
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };

      clean = {
        requireForce = false;
      };
    };
  };
}
