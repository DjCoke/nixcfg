{ config, ... }: {
  imports = [
    ./home.nix
    ../features/cli
    ../features/desktop
    ./dotfiles
    ../common
  ];

  features = {
    cli = {
      zsh.enable = true;
      fish.enable = false;
      starship.enable = true;
      fzf.enable = true;
      git.enable = true;
      neofetch.enable = true;
    };
    desktop = {
      fonts.enable = true;
    };
  };
}
