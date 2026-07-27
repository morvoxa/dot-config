{
  config,
  pkgs,
  lib,
  isWsl ? false,
  ...
}:
{
  home.username = "mor";
  home.homeDirectory = "/home/mor";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages =
    with pkgs;
    [
      # CLI Tools ()
      git
      devenv
      tmux
      fastfetch
      neovim
      fzf
      tree-sitter
      tree
      xclip
      gcc
      #Neovim LSP + Formater
      taplo
      nixfmt
      stylua
      clang-tools
      lua-language-server
      tailwindcss-language-server
      vtsls
      vscode-langservers-extracted
      emmet-ls
      yaml-language-server
    ]
    # Gui for Linux
    ++ lib.optionals (!isWsl) [
      firefox
      alacritty
      vscodium
    ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(direnv hook bash)"
      alias ls="ls --color=auto"
    '';
  };
}
