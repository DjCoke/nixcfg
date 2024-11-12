{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.features.cli.zsh;
  in {
      options.features.cli.zsh.enable = mkEnableOption "Enable extended zsh configuration";

      config = mkIf cfg.enable {
          programs.zsh = {
            enable = true;
            loginExtra = ''
            # Neofetch wordt uitgevoerd bij het openen van elke nieuwe interactieve shell
            ${pkgs.neofetch}/bin/neofetch
            '';
            shellAliases = {
            ".." = "cd ..";
            "..." = "cd ../..";
            ls = "eza";
            grep = "rg";
            ps = "procs";
            };
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;
            history.size = 10000;
            history.share = true;
          };
      };
  }
