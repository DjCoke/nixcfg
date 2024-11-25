{ config, lib, ... }:
with lib; let
  cfg = config.features.cli.git;
in
{
  options.features.cli.git.enable = mkEnableOption "Enable git configuration";

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "DjCoke";
      userEmail = "8378780+DjCoke@users.noreply.github.com";

    };
  };
}
