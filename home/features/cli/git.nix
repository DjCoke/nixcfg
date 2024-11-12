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
      userEmail = "erwin.vd.glind@me.com";

    };
  };
}
