{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.erwin = {
    initialHashedPassword = "$y$j9T$n6.MFd7asV3/59Z9k9CX70$MvAaB0zG0gOjXRakN1koC3El2KGFjsnmhL.bGaojCv7";
    isNormalUser = true;
    description = "Erwin";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];
    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXGrUwai6ZD75n5rPTl06f0gEMtzJU0W8xFnR9YPghE"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.erwin =
    import erwin/${config.networking.hostName}.nix;
}

