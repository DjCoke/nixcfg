{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.features.cli.zsh;
  in {
      options.features.cli.zsh.enable = mkEnableOption "Enable extended zsh configuration";

      config = mkIf cfg.enable {
        programs.zsh = {
          enable = true;
          loginExtra = ''
          set -x NIX_PATH nixpkgs=channel:nixos-unstable
          set -x NIX_LOG info

          '';
          loginExtra = ''
           ${pkgs.neofetch}/bin/neofetch
           '';
          shellAliases = {
            ".." = "cd ..";
            "..." = "cd ../..";
            ls = "eza";
            grep = "rg";
            ps = "procs";
          };
        };
      };
  }
