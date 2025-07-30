{
  description = "Esoteric Enderman's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    home-manager.url = "github:nix-community/home-manager?ref=release-24.11";
    plasma-manager.url = "github:nix-community/plasma-manager";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nix4vscode.url = "github:nix-community/nix4vscode";
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, nix4vscode, ... }@inputs: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration.nix
        home-manager.nixosModules.default

        nix-flatpak.nixosModules.nix-flatpak

        {
          nixpkgs.overlays = [
            nix4vscode.overlays.forVscode
          ];
        }
      ];

      specialArgs = { inherit inputs self; };
    };
  };
}
