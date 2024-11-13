{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.features.cli.aerospace;
in
{
  options.features.cli.aerospace.enable = mkEnableOption "Enable Aerospace";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ aerospace ];

  };
}
