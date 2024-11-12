{ pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./alacritty.nix
    #./hyprland.nix
    #./wayland.nix
  ];

  home.packages = with pkgs; [
  ];
}
