{
  programs.git = {
    enable = true;

    extraConfig = {
      core = {
        editor = "codium --wait";
      };

      init = {
        defaultBranch = "main";
      };

      status = {
        branch = true;
        showStash = true;
      };

      push = {
        autoSetupRemote = true;
        recurseSubmodules = "on-demand";
      };

      pull = {
        ff = "only";
      };

      receive = {
        denyCurrentBranch = "updateInstead";
      };

      clean = {
        requireForce = false;
      };

      submodule = {
        recurse = true;
      };

      advice = {
        forceDeleteBranch = false;
        detachedHead = false;
      };

      alias = {
        profile = "! git config user.name && git config user.email";

        authors = "!f() { ${../../scripts/git/authors.sh} \"$@\"; }; f";
        committers = "!f() { ${../../scripts/git/committers.sh} \"$@\"; }; f";
        contributors = "!f() { ${../../scripts/git/contributors.sh} \"$@\"; }; f";

        info = "cat-file -p";
        current = "info HEAD";
        count = "rev-list --count HEAD";

        ls = "ls-files";

        check = "ls-remote";

        code = "config --local core.editor \"codium --wait\"";
        idea = "config --local core.editor \"idea-community --wait\"";

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

        rename = "!f() { ${../../scripts/git/rename}/rename-author.sh \"$@\"; }; f";
        clone-all = "!f() { ${../../scripts/git/clone-all.sh} \"$@\"; }; f";
        clone-gists = "!f() { ${../../scripts/git/clone-gists}/clone-gists.sh \"$@\"; }; f";

        force = "push --force";

        wipe = "restore .";
      };

      "url \"git@gitlab.com:shdima/\"" = {
        insteadOf = "me:";
      };

      "url \"git@github.com:\"" = {
        insteadOf = "gh:";
      };

      "url \"git@gitlab.com:\"" = {
        insteadOf = "gl:";
      };
    };

    ignores = [
      ".idea/"
      "template.iml"
      ".bash_history"
      ".bash_history-[0-9][0-9][0-9][0-9][0-9].tmp"
      ".python_history"
    ];
  };
}
