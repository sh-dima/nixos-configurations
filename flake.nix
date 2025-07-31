{
  description = "Esoteric Enderman's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    home-manager.url = "github:nix-community/home-manager?ref=release-24.11";
    plasma-manager.url = "github:nix-community/plasma-manager";

    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/stable-v3";

    nix4vscode.url = "github:nix-community/nix4vscode";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
  };

  outputs = { self, nixpkgs, home-manager, flatpaks, nix4vscode, ... }@inputs: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration.nix
        home-manager.nixosModules.default

        flatpaks.nixosModule

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
