{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.features.desktop.wezterm;
in
{
  options.features.desktop.wezterm.enable = mkEnableOption "Enable Wezterm";

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
}
