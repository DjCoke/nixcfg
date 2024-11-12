{ pkgs, ... }: {
  imports = [
    ./fish.nix
    ./zsh.nix
    ./fzf.nix
    ./neofetch.nix
  ];

  # Configuration of git
  programs.git = {
    enable = true;
    userName = "DjCoke";
    userEmail = "erwin.vd.glind@me.com";
  };



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

  #Configuration of Starship
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

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
  ];

}
