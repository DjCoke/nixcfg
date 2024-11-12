{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.erwin = {
    # isNormalUser = true;
    home = "/Users/erwin";
    description = "Erwin van de Glind";
    shell = pkgs.zsh; # Stel hier de gewenste shell in, bijvoorbeeld Fish
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  # home-manager.users.erwin =
  #  import ../../../home/erwin/macbook-pro.nix;
}

