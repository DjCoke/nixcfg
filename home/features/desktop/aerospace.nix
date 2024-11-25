{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.features.desktop.aerospace;
in
{
  options.features.desktop.aerospace.enable = mkEnableOption "Enable Aerospace";

  config = mkIf cfg.enable {
    # home.packages = with pkgs; [ aerospace ];
    # homebrew.casks = [ "aerospace" ];
  };
}
