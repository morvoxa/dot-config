{
  config,
  pkgs,
  lib,
  isWsl ? false,
  nixpkgs,
  ...
}:
{
  home.username = "mor";
  home.homeDirectory = "/home/mor";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
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
      vscode.fhs
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
      eval "$(direnv hook bash)"
      alias ls="ls --color=auto"
    '';
  };
}
