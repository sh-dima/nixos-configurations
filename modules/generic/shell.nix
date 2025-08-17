{
  environment.interactiveShellInit = ''
    alias rebuild='sudo nixos-rebuild switch'

    alias try='nix-shell -p'

    alias size='du -hs'
  '';
}
