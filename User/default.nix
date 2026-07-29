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
      wl-clipboard-rs
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

  programs.tmux = {
    enable = true;
    extraConfig = ''
      bind-key -n M-h previous-window
      bind-key -n M-l next-window
    '';
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ -z "$TMUX" && $- == *i* ]]; then
        if command -v tmux &> /dev/null; then
          tmux attach-session -t default 2>/dev/null || tmux new-session -s default
          exit
        fi
      fi

      eval "$(direnv hook bash)"
      alias ls="ls --color=auto"
    '';
  };
}
