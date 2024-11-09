{ lib, pkgs, ... }: {
  # Configuration Home Manager

  home = {
    stateVersion = "24.05";
    packages = with pkgs; [
      ripgrep
      fd
      curl
      less
      coreutils
      htop
      httpie
      jq
      procs
      tldr
      zip
    ];
    sessionVariables = {
      PAGER = "less";
      CLICLOLOR = 1;
      EDITOR = "nvim";
    };
    file.".config/nvim" = {
      source = "${inputs.dotfiles}/nvim";
      recursive = true;
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
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;

      colors = {
        "fg" = "#f8f8f2";
        "bg" = "#282a36";
        "hl" = "#bd93f9";
        "fg+" = "#f8f8f2";
        "bg+" = "#44475a";
        "hl+" = "#bd93f9";
        "info" = "#ffb86c";
        "prompt" = "#50fa7b";
        "pointer" = "#ff79c6";
        "marker" = "#ff79c6";
        "spinner" = "#ffb86c";
        "header" = "#6272a4";
      };
      defaultOptions = [
        "--preview='bat --color=always -n {}'"
        "--bind 'ctrl-/:toggle-preview'"
      ];
      defaultCommand = "fd --type f --exclude .git --follow --hidden";
      changeDirWidgetCommand = "fd --type d --exclude .git --follow --hidden";
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    # Configuration of exa which is a ls replacement
    eza = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      extraOptions = [ "-l" "--icons" "--git" "-a" ];
    };

    # Configutation of zsh
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      #   shellAliases = { ls = "ls --color=auto -F"; };
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
