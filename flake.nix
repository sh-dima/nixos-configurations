{
  description = "Dima's NixOS configurations";

  inputs = {
    secrets = {
      url = "git+ssh://git@gitlab.com/shdima/secrets.git?ref=main&shallow=1";
      flake = false;
    };

    sops-nix.url = "github:mic92/sops-nix";

    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    home-manager.url = "github:nix-community/home-manager?ref=release-25.11";
    plasma-manager.url = "github:nix-community/plasma-manager";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nix4vscode.url = "github:nix-community/nix4vscode";
    nix-jetbrains-plugins.url = "github:Janrupf/nix-jetbrains-plugin-repository";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, nix4vscode, prismlauncher, flake-utils, ... }@inputs:
    let
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/pc/configuration.nix
            ./hosts/pc/hardware-configuration.nix
            home-manager.nixosModules.default

            nix-flatpak.nixosModules.nix-flatpak

            {
              nixpkgs.overlays = [
                nix4vscode.overlays.forVscode
                inputs.nix-jetbrains-plugins.overlays.default
                prismlauncher.overlays.default
              ];
            }
          ];

          specialArgs = { inherit inputs; };
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/laptop/configuration.nix
            ./hosts/laptop/hardware-configuration.nix
            home-manager.nixosModules.default

            nix-flatpak.nixosModules.nix-flatpak

            {
              nixpkgs.overlays = [
                nix4vscode.overlays.forVscode
                inputs.nix-jetbrains-plugins.overlays.default
                prismlauncher.overlays.default
              ];
            }
          ];

          specialArgs = { inherit inputs; };
        };
      };
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.python = pkgs.mkShell {
          buildInputs = with pkgs; [
            python3
            python3Packages.pip
            python3Packages.virtualenv
          ];

          shellHook = ''
            if [ ! -d .venv ]; then
              python -m venv .venv
            fi

            source .venv/bin/activate
          '';
        };
      }) // { inherit nixosConfigurations; };
}
