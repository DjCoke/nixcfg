{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.features.desktop.alacritty;
in
{
  options.features.desktop.alacritty.enable = mkEnableOption "Enable Alacritty";

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      # Settings of Alacritty
      settings = {
        font = {
          normal.family = "MesloLGS Nerd Font Mono";
          size = 16;
        };

        window = {
          opacity = 1.0;
          padding = {
            x = 24;
            y = 24;
          };
        };
      };

    };
  };
}
