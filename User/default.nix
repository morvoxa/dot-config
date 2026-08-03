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
      gcc
      openssh
      just
      fd
      ripgrep
      #Neovim LSP + Formater
      taplo
      nixfmt
      prettier
      shfmt
      stylua
      lua-language-server
      nixd
    ]
    # Gui for Linux
    ++ lib.optionals (!isWsl) [
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
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(direnv hook bash)"
      alias ls="ls --color=auto"
    '';
  };
}
