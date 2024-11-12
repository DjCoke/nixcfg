{ config, ... }: { imports = [
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
     };
     desktop = {
       fonts.enable = true;
     };
  };
}
