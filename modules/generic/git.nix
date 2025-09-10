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
      detachedHead = false;
    };

    alias = {
      profile = "! git config user.name && git config user.email";

      authors = "! git log --format='%aN <%aE>' | sort -u";
      committers = "! git log --format='%cN <%cE>' | sort -u";
      contributors = "! git log --format='%aN <%aE>%n%cN <%cE>' | sort -u";

      info = "cat-file -p";
      current = "info HEAD";
      count = "rev-list --count HEAD";

      ls = "ls-files";

      check = "ls-remote";

      origin = "remote add origin";
      upstream = "remote add upstream";

      back = "checkout HEAD^1";
      forward = "! git checkout $(git rev-list --topo-order HEAD..main | tail -1)";

      first = "! git checkout `git rev-list --max-parents=0 HEAD | tail -n 1`";

      change = "! git add . && git commit";

      amend = "commit --amend";
      rewrite = "commit --amend --reset-author";
      revise = "! git add . && git amend";
      redo = "! git add . && git rewrite";

      rename = "!f() { ${../../scripts/git/rename-author.sh} \"$@\"; }; f";

      force = "push --force";

      wipe = "restore .";
    };
  };

  ignores = [
    ".idea/"
    ".bash_history"
    ".python_history"
  ];
}
