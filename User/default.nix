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
      fastfetch
      neovim
      fzf
      tree-sitter
      tree
      nixd
      xclip
      gcc
      openssh
      #Neovim LSP + Formater
      taplo
      nixfmt
      prettier
      fd
      ripgrep
      stylua
      clang-tools
      lua-language-server
      tailwindcss-language-server
      vtsls
      vscode-langservers-extracted
      emmet-ls
      yaml-language-server
      just
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

  programs.zellij = {
    enable = true;
    settings = {
      keybinds = {
        unbind = [
          "Ctrl h"
          "Ctrl l"
        ];
      };
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(direnv hook bash)"
      alias ls="ls --color=auto"
      if [[ -z "$ZELLIJ" && $- == *i* ]]; then
      if command -v zellij &> /dev/null; then
      exec zellij attach -c
      fi
      fi
    '';
  };
}
