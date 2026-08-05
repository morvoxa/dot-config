{
  pkgs,
  ...
}:
{
  home.username = "mor";
  home.homeDirectory = "/home/mor";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    neovim
    nixd
    nixfmt
    clang-tools
    stylua
    lua-language-server
    tree-sitter
    shfmt
    zip
    unzip
    prettier
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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
