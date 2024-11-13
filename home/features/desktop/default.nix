{ pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./alacritty.nix
    ./wezterm.nix
    ./aerospace.nix
    #./hyprland.nix
    #./wayland.nix
  ];

  home.packages = with pkgs; [
  ];
}
