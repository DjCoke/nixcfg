{ pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./alacritty.nix
    ./wezterm.nix
    #./hyprland.nix
    #./wayland.nix
  ];

  home.packages = with pkgs; [
  ];
}
