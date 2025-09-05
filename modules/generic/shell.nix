{
  environment.interactiveShellInit = ''
    alias rebuild='sudo nixos-rebuild switch'

    alias try='nix-shell -p'

    alias size='du -hs'

    alias ram='free'
    alias memory='free'
    alias mem='free'

    alias recall='history | grep'
  '';
}
