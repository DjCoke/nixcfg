{ inputs
, ...
}:
{
  imports = [
    ./bat.nix
  ];

  home.file.".config/nvim" = {
    source = "${inputs.dotfiles}/nvim";
    recursive = true;
  };
  home.file.".config/aerospace" = {
    source = "${inputs.dotfiles}/aerospace";
    recursive = true;
  };
}

