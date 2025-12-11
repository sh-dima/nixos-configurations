{ ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.settings.auto-optimise-store = true;

  nix.settings.keep-outputs = true;
  nix.settings.keep-derivations = true;

  nix.settings.trusted-users = [
    "root"
    "dima"
  ];
}
