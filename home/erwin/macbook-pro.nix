{ config, ... }: { imports = [
    ./home-darwin.nix
   ../features/cli
  #   ../features/desktop
  #   ./dotfiles
     ../common
  ];

  # features = {
  #   cli = {
  #     fish.enable = true;
  #     fzf.enable = true;
  #     neofetch.enable = true;
  #   };
  #   desktop = {
  #     fonts.enable = true;
  #   };
  # };
}
