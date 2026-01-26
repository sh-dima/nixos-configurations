{ pkgs, ... }:

{
  environment.interactiveShellInit = ''
    __set_ps1() {
      if [[ -n "$IN_NIX_SHELL" ]]; then
        PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]nix-shell:\w]\$ \[\033[0;34m\]$(__git_ps1 "(%s) ")\[\033[0m\]'
      else
        # Original: '\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
        PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\w]\$ \[\033[0;34m\]$(__git_ps1 "(%s) ")\[\033[0m\]'
      fi
    }

    PROMPT_COMMAND="__set_ps1"

    alias rebuild='sudo nixos-rebuild switch'

    alias try='nix-shell -p'
    alias tmp='cd $(mktemp -d)'

    alias size='du -hs'
    alias count='wc -l'

    alias ram='free'
    alias memory='free'
    alias mem='free'

    alias recall='history | grep'

    source '${builtins.unsafeDiscardStringContext pkgs.git}/share/bash-completion/completions/git-prompt.sh'

    export VIRTUAL_ENV_DISABLE_PROMPT=1

    export HISTSIZE=-1
    export HISTFILESIZE=-1

    loop() {
      for dir in */ ; do
        [ -d "$dir" ] || continue
        (cd "$dir" && "$@")
      done
    }
  '';
}
