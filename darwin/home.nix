{ lib
, pkgs
, #  pwnvim,
  ...
}: {
  # Configuration Home Manager

  home = {
    stateVersion = "24.05";
    packages = [
      pkgs.ripgrep
      pkgs.fd
      pkgs.curl
      pkgs.less
      #     pwnvim.packages."aarch64-darwin".default
    ];
    sessionVariables = {
      PAGER = "less";
      CLICLOLOR = 1;
      EDITOR = "nvim";
    };
  };

  # Configuration of all our programs via Home Manager
  # Valuable read: https://nixos.wiki/wiki/Visual_Studio_Code
  programs = {
    # Configuration of git
    git = {
      enable = true;
      userName = "DjCoke";
      userEmail = "erwin.vd.glind@me.com";
    };


    #Configuration of Visual Studio Code
    vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;
      extensions = with pkgs.vscode-extensions; [
        yzhang.markdown-all-in-one
        dracula-theme.theme-dracula
        ms-vscode-remote.remote-ssh
        jnoortheen.nix-ide
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "beautiful-dracula";
          publisher = "NguyenHoangLam";
          version = "0.1.4";
          sha256 = "H8O6PkpwcPFiRRp17FmM05JtZ5suIJWn+FtGf5YMquU=";
        }
      ];

      # User Settings
      # Stolen from https://discourse.nixos.org/t/home-manager-vscode-extension-settings-mutableextensionsdir-false/33878
      userSettings = {
        # General
        "editor.fontSize" = 16;
        "editor.fontFamily" = "'Jetbrains Mono', 'monospace', monospace";
        "terminal.integrated.fontSize" = 14;
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
        "window.zoomLevel" = 1;
        "workbench.startupEditor" = "none";
        "explorer.compactFolders" = false;
        # Whitespace
        "files.trimTrailingWhitespace" = true;
        "files.trimFinalNewlines" = true;
        "files.insertFinalNewline" = true;
        "diffEditor.ignoreTrimWhitespace" = false;
        # Git

        # https://stackoverflow.com/questions/74462667/is-that-good-idea-to-disable-gpg-signin-for-code-commits
        "git.enableCommitSigning" = false;
        # Styling
        "window.autoDetectColorScheme" = true;
        "workbench.preferredDarkColorTheme" = "Beautiful Dracula Darker";
        "workbench.preferredLightColorTheme" = "Beautiful Dracula Normal";
        "workbench.colorTheme" = "Beautiful Dracula Darker";
        "workbench.iconTheme" = "material-icon-theme";
        "material-icon-theme.activeIconPack" = "none";
        "material-icon-theme.folders.theme" = "classic";
        # Other
        "telemetry.telemetryLevel" = "off";
        "update.showReleaseNotes" = false;
        "git.autofetch" = true;
      };
    };

    # Replacement of cat
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };

    # Configuration of the Fuzzy Finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # Configuration of exa which is a ls replacement
    eza.enable = true;

    # Configutation of zsh
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = { ls = "ls --color=auto -F"; };
      history.size = 10000;
      history.share = true;
    };

    #Configuration of Starship
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    # Configuration of Alacritty
    alacritty = {
      enable = true;

      # Settings of Alacritty
      settings = {
        font = {
          normal.family = "MesloLGS Nerd Font Mono";
          size = 16;
        };

        window = {
          opacity = 1.0;
          padding = {
            x = 24;
            y = 24;
          };
        };
      };
    };
  };
}
