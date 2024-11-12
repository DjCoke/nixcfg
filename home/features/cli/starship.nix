{ config, lib, ... }:
with lib; let
  cfg = config.features.cli.starship;
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
