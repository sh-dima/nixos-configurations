{
  environment.interactiveShellInit = ''
    alias rebuild='sudo nixos-rebuild switch'

    alias try='nix-shell -p'

    alias size='du -hs'

    alias ram='free'
    alias memory='free'
    alias mem='free'

    alias recall='history | grep'

    # Original: '\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
    PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\w]\$\[\033[0m\] '
  '';
}
