{
  description = "System flake configuration file";

  # Followed the instructions of Dreams of Autonomy, https://youtu.be/Z8BL8mdzWHI?si=K83jL15NjsDWIPti
  # But renamed the inputs to more logical names (see zmre 14:30 minute mark)
  # Only thing is that App Store Apps don't seem to work, but renamed some conventions or time passed by, and suddenly it worked...
  # Next we will follow instruction of zmre, https://youtu.be/LE5JR4JcvMg?si=9Bigvv_AAOEBUsoT
  # Vervolgens ben ik ook gaan kijken naar: https://blog.dbalan.in/blog/2024/03/25/boostrap-a-macos-machine-with-nix/index.html
  # Dit betreft in mijn visie een veel duidelijkere flake

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
    nix-homebrew = {url = "github:zhaofengli-wip/nix-homebrew";};

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

    # tricked out nvim from
    pwnvim.url = "github:zmre/pwnvim";
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    homebrew-bundle,
    pwnvim,
    ...
  } @ inputs: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MacBook-Pro
    darwinConfigurations."MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      # Definieer pkgs door nixpkgs te importeren voor aarch64-darwin (Apple Silicon)
      modules = [
        ./configuration.nix
        home-manager.darwinModules.home-manager
        {
          # `home-manager` config
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.erwin = import ./home.nix {
              lib = (import nixpkgs {system = "aarch64-darwin";}).lib;
              pkgs = import nixpkgs {
                system = "aarch64-darwin";
                config.allowUnfree = true;
              };
              inherit pwnvim;
            };
          };
        }

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;
            user = "erwin";

            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
            mutableTaps = false;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."MacBook-Pro".pkgs;
  };
}
