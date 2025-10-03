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
    age.keyFile = "/home/dima/.config/sops/age/keys.txt";

    secrets = {
      "users/dima/name" = {
        owner = "root";
        group = "root";

        neededForUsers = true;
       };

      "hosts/pc/users/dima/password-hash" = {
        neededForUsers = true;
      };

      "hosts/laptop/users/dima/password-hash" = {
        neededForUsers = true;
      };

      "assets/images/pfps/dima.png" = {
        format = "binary";
        sopsFile = "${secrets}/assets/images/pfps/dima.json";
      };
    };
  };
}
