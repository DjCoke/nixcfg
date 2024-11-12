{ config, ... }: {
  imports = [
    ./home-darwin.nix
    ../features/cli
    ../features/desktop
    ./dotfiles
    ../common
  ];

  features = {
    cli = {
      zsh.enable = true;
      fzf.enable = true;
      neofetch.enable = true;
      starship.enable = true;
      git.enable = true;
    };
    desktop = {
      alacritty.enable = true;
      wezterm.enable = true;
      fonts.enable = true;
    };
  };
}
