{
  programs.git = {
    enable = true;

    settings = {
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
        history = "log --follow --";

        check = "ls-remote";
        sync = "!f() { ${../../scripts/git/sync.py} \"$@\"; }; f";

        code = "config --local core.editor \"codium --wait\"";
        idea = "config --local core.editor \"idea-community --wait\"";

        origin = "!f() { ${../../scripts/git/origin.py} \"$@\"; }; f";
        upstream = "remote add upstream";

        back = "checkout HEAD^1";
        forward = "! git checkout $(git rev-list --topo-order HEAD..main | tail -1)";

        first = "! git checkout `git rev-list --max-parents=0 HEAD | tail -n 1`";

        prepare = "!f() { ${../../scripts/git/prepare}/prepare.sh \"$@\"; }; f";

        update = "!f() { ${../../scripts/git/update.py} \"$@\"; }; f";
        change = "! git add . && git update";

        amend = "commit --amend";
        rewrite = "commit --amend --reset-author";
        revise = "! git add . && git amend";
        redo = "! git add . && git rewrite";

        rename = "!f() { ${../../scripts/git/rename}/rename-author.sh \"$@\"; }; f";
        remap-submodule = "!f() { ${../../scripts/git/remap-submodules}/remap-submodule.py \"$@\"; }; f";
        clone-all = "!f() { ${../../scripts/git/clone-all.sh} \"$@\"; }; f";
        clone-gists = "!f() { ${../../scripts/git/clone-gists}/clone-gists.sh \"$@\"; }; f";

        tags = "push --tags";

        force = "push --force";
        retag = "tags --force";

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
      "*.iml"
      ".bash_history"
      ".bash_history-[0-9][0-9][0-9][0-9][0-9].tmp"
      ".python_history"
    ];
  };
}
