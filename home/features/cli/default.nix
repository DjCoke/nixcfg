{ pkgs, ... }: {
  imports = [
    ./fish.nix
    ./zsh.nix
    ./fzf.nix
    ./git.nix
    ./starship.nix
    ./neofetch.nix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraOptions = [ "-l" "--icons" "--git" "-a" ];
  };

  programs.bat = { enable = true; };

  home.packages = with pkgs; [
    coreutils
    fd
    htop
    httpie
    jq
    procs
    ripgrep
    tldr
    zip
    curl
    less
    pet
    gh
    kubectl
    kubectx
    yq
    just
    k9s
    tree
    jetbrains-mono
    cargo
    warp-terminal
  ];

}
