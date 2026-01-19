# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, config, ... }:

{
  imports = [
    ../../modules/generic/nix.nix
    ../../modules/generic/gpg.nix
    ../../modules/generic/sops.nix

    ../../modules/generic/shell.nix
    ../../modules/generic/llm.nix
    ../../modules/generic/java.nix

    ../../modules/generic/idea.nix

    ../../modules/generic/fonts.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pc";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [
  ];

  time.timeZone = "Europe/Dublin";

  i18n.defaultLocale = "en_IE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_NUMERIC = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ru,de";
    variant = ",phonetic,";

    options = "grp:alt_shift_toggle";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.udisks2.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.dima = {
    name = "dima";
    isNormalUser = true;
    home = "/home/dima";
    uid = 1000;
    hashedPasswordFile = config.sops.secrets."hosts/pc/users/dima/password-hash".path;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  system.activationScripts.setUserDescription.text = ''
    usermod -c "$(cat ${config.sops.secrets."users/dima/name".path})" dima
  '';

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    git-filter-repo
    gocryptfs
    gh
    gource
    age
    gnupg
    pinentry-qt
    sops
    typst
    usbimager
    gnome-disk-utility
    vscodium
    nixd
    zip
    unzip
    wl-clipboard
    sqlitebrowser
    transmission_4-gtk
    vlc
    python3
    exiftool
    mat2
    jadx
    tinymist
    texlive.combined.scheme-full

    protonvpn-gui
    proton-pass
    protonmail-export
    brave
    geogebra6
    freetube
    bitwarden-desktop
    obsidian
    libreoffice

    prismlauncher
    mcpelauncher-ui-qt
    lutris
    superTuxKart
    mcaselector
    inkscape
    krita
    gimp
    obs-studio
    kdePackages.kdenlive
    element-desktop

    fira-code
  ];

  fonts.fontconfig.enable = true;

  virtualisation.waydroid.enable = true;
  programs.steam.enable = true;

  services.flatpak.enable = true;

  programs.kdeconnect.enable = true;

  home-manager.sharedModules = [
    inputs.plasma-manager.homeModules.plasma-manager
    inputs.sops-nix.homeManagerModules.sops
  ];

  home-manager.backupFileExtension = pkgs.lib.readFile "${pkgs.runCommand "timestamp" {} "echo -n `date '+%Y%m%d%H%M%S'` > $out"}" + ".bak";
  home-manager.users.dima = (import ./users/dima.nix { inherit inputs pkgs config; });

  environment.etc."/brave/policies/managed/GroupPolicy.json".source = ../../modules/generic/brave/policies.json;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
