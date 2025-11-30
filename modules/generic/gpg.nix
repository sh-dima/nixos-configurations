{ ... }: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;

    settings = {
      default-cache-ttl = 3600 * 3;
      max-cache-ttl = 86400;
    };
  };
}
