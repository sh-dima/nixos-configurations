{ inputs, ... }:
let
  secrets = builtins.toString inputs.secrets;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${secrets}/secrets.yaml";
    age.keyFile = "/home/enderman/.config/sops/age/keys.txt";

    secrets = {
      "user/name" = { };
      
      "hosts/pc/password" = {
        neededForUsers = true;
      };
    };
  };
}
