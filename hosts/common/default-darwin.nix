# Common configuration for all hosts

{ pkgs, lib, nixpkgs, config, inputs, outputs, ... }: {
  imports = [
    ./users/erwinvandeglind.nix
  #inputs.home-manager.nixosModules.home-manager
  inputs.home-manager.darwinModules.home-manager
  ];
  home-manager = {
  	useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    # useGlobalPkgs = true;
              users.erwinvandeglind = import ../../home/erwin/macbook-pro.nix {
                lib = (import nixpkgs { system = "aarch64-darwin"; }).lib;
                pkgs = import nixpkgs {
                  system = "aarch64-darwin";
                  config.allowUnfree = true;
                };
                config = config; # Geef `config` expliciet door
                inputs = inputs; # Geef inputs expliciet door aan home.nix
              };
  };
 nixpkgs = {
    # You can add overlays here
    overlays = [
    # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
       outputs.overlays.modifications
       outputs.overlays.stable-packages
  
    # You can also add overlays exported from other flakes:
          # neovim-nightly-overlay.overlays.default
  
       # Or define it inline, for example:
       # (final: prev: {
       #   hi = final.hello.overrideAttrs (oldAttrs: {
       #     patches = [ ./change-hello-to-hi.patch ];
       #   });
       # })
     ];
     # Configure your nixpkgs instance
    config = {
     # Disable if you don't want unfree packages
       allowUnfree = true;
    };
 };
  #
   nix = {
     settings = {
       experimental-features = "nix-command flakes";
       trusted-users = [
         "root"
         "erwinvandeglind"
         "erwin"
         "@admin"
       ]; # Set users that are allowed to use the flake command
     };
     gc = {
       automatic = true;
       options = "--delete-older-than 30d";
     };
     optimise.automatic = true;
     registry = (lib.mapAttrs (_: flake: { inherit flake; }))
       ((lib.filterAttrs (_: lib.isType "flake")) inputs);
     nixPath = [ "/etc/nix/path" ];
   };
  # users.defaultUserShell = pkgs.fish; Werkt niet in darwinConfigurations
}
