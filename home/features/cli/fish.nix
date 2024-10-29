{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.features.cli.fish;
  in {
      options.features.cli.fish.enable = mkEnableOption "Enable extended fish configuration";

      config = mkIf cfg.enable {
        programs.fish = {
          enable = true;
          loginShellInit = ''
          set -x NIX_PATH nixpkgs=channel:nixos-unstable
          set -x NIX_LOG info

          '';
           interactiveShellInit = ''
           ${pkgs.neofetch}/bin/neofetch
           '';
          shellAbbrs = {
            ".." = "cd ..";
            "..." = "cd ../..";
            ls = "eza";
            grep = "rg";
            ps = "procs";

          };
        };
      };
  }
