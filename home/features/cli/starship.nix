{ config, lib, ... }:
with lib; let
  cfg = config.features.starship.fzf;
in
{
  options.features.cli.starship.enable = mkEnableOption "Enable Starship prompt";

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
}
