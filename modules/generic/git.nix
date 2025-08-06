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

    alias = {
      authors = "! git log --format='%aN <%aE>' | sort -u";
      committers = "! git log --format='%cN <%cE>' | sort -u";
      contributors = "! git log --format='%aN <%aE>%n%cN <%cE>' | sort -u";
    };
  };
}
