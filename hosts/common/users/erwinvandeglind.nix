{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.erwinvandeglind = {
    # isNormalUser = true;
    home = "/Users/erwinvandeglind";
    description = "Erwin van de Glind";
    shell = pkgs.zsh; # Stel hier de gewenste shell in, bijvoorbeeld Fish
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  # home-manager.users.erwinvandeglind =
  #  import ../../../home/erwin/macbook-pro.nix;
}

