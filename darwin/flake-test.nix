{ description = "Darwin flake which is basically the same as the flake.nix in root"

  # Followed the instructions of Dreams of Autonomy, https://youtu.be/Z8BL8mdzWHI?si=K83jL15NjsDWIPti
  # But renamed the inputs to more logical names (see zmre 14:30 minute mark)
  # Only thing is that App Store Apps don't seem to work, but renamed some conventions or time passed by, and suddenly it worked...
  # Next we will follow instruction of zmre, https://youtu.be/LE5JR4JcvMg?si=9Bigvv_AAOEBUsoT
  # Vervolgens ben ik ook gaan kijken naar: https://blog.dbalan.in/blog/2024/03/25/boostrap-a-macos-machine-with-nix/index.html
  # Dit betreft in mijn visie een veel duidelijkere flake

  # 10-11-2024 I had a seperate config for my Darwin Flake and one for all my other systems
  # I wanted to combine the with the same technique, /home for home-manager and hosts for my configuration
  # Otherwise would be obliged to have two different ways of configuration

  inputs = {
    # Where we get most of our Software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Controls system level software and settings including fonts
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Manages the homebrew package system
    nix-homebrew = { url = "github:zhaofengli-wip/nix-homebrew"; };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    dotfiles = {
      url = "git+https://github.com/DjCoke/dotfiles.git";
      flake = false;
    };

  };

  outputs = {
    self
    , nix-darwin
    , nixpkgs
    , home-manager
    , nix-homebrew
    , homebrew-core
    , homebrew-cask
    , homebrew-bundle
    , dotfiles
    , ...}@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages =
        forAllSystems (system: import ../pkgs nixpkgs.legacyPackages.${system});
      overlays = import ../overlays { inherit inputs; };

      nixosConfigurations = {
        sandbox = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ../hosts/sandbox ];
        };
      };

      darwinConfigurations = {
        "MacBook-Pro" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # Pas aan als je op een Intel Mac werkt
          modules = [
            ../hosts/macbook-pro # Voeg je specifieke macOS-configuratiebestand toe
          ];
        };
      };

      homeConfigurations = {
        # Linux Home Manager Configuratie
        "erwin@sandbox" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ../home/erwin/sandbox.nix ];
        };

        # macOS Home Manager Configuratie voor MacBook-Pro
        "erwin@MacBook-Pro" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin"; # Of "x86_64-darwin" voor Intel
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ../home/erwin/macbook-pro.nix ];
        };
      };
    };
}

