{
  extraConfig = {
    init = {
      defaultBranch = "main";
    };

    push = {
      autoSetupRemote = true;
    };

    clean = {
      requireForce = false;
    };

    advice = {
      forceDeleteBranch = false;
    };
  };
}
