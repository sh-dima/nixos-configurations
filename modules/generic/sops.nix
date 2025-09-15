{ inputs, config, ... }:
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
      "user/name" = {
        owner = "root";
        group = "root";
       };

      "hosts/pc/password" = {
        neededForUsers = true;
      };

      "hosts/laptop/password" = {
        neededForUsers = true;
      };
    };
  };
}
