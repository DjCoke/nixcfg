{ config, ... }: { imports = [
    ./home.nix
    ../features/cli
    ./dotfiles
    ../common
  ];

  features = {
    cli = {
      fish.enable = true;
      fzf.enable = true;
      neofetch.enable = true;
    };
    desktop = {
      fonts.enable = true;
    };
  };
}
