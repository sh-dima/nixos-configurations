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
      profile = "! git config user.name && git config user.email";

      authors = "! git log --format='%aN <%aE>' | sort -u";
      committers = "! git log --format='%cN <%cE>' | sort -u";
      contributors = "! git log --format='%aN <%aE>%n%cN <%cE>' | sort -u";

      count = "rev-list --count HEAD";

      ls = "ls-files";

      back = "checkout HEAD^1";
      forward = "! git checkout $(git rev-list --topo-order HEAD..main | tail -1)";

      change = "! git add . && git commit";

      amend = "commit --amend";
      rewrite = "commit --amend --reset-author";

      force = "push --force";

      wipe = "restore .";
    };
  };
}
