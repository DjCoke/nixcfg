{ config
, lib
, pkgs
, ...
}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    obsidian
    tmux
    coreutils
    mkalias
    neovim
    alacritty
    curl
    gitAndTools.gitFull
    mg
    lazygit
    nodejs
  ];

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    brews = [
      "mas"
    ];
    casks = [
      # Browsers
      "firefox"
      "google-chrome"

      "the-unarchiver"
      "raycast"
      "discord"
      "loom"
      "notion"
      "slack"
      "telegram"
      "zoom"
      "syncthing"

      # Entertainment Tools
      "steam"
      "vlc"
    ];
    masApps = {
      "Dashlane" = 517914548;
      "Pages" = 409201541;
    };
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Installing my favorite fonts system-wide
  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" ]; }) ];

  # users.users.erwinvandeglind.home = "/Users/erwinvandeglind";
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  nix.gc = {
    user = "root";
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 2;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  environment.shells = [ pkgs.bash pkgs.zsh ];
  environment.loginShell = pkgs.zsh;
  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [ "/Applications" ];
  # programs.fish.enable = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # Used for building Linux Machines
  # https://nixcademy.com/posts/macos-linux-builder/
  # nix.configureBuildUsers = true;
  # nix.linux-builder = {
  #   enable = true;
  #   ephemeral = true;
  #   maxJobs = 4;
  #   config = {
  #     virtualisation = {
  #       darwin-builder = {
  #         diskSize = 40 * 1024;
  #         memorySize = 8 * 1024;
  #       };
  #       cores = 6;
  #     };
  #   };
  # };
  nix.settings.trusted-users = [ "@admin" ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Apple System configurations system-wide
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.dock.autohide = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';
}
