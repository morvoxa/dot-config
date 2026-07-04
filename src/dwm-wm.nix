{ pkgs, ... }: {

  services.displayManager.ly.enable = true;
  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        postPatch = ''
          cp ${./config.h} config.h
        '';
      };
    };
  };

  environment.systemPackages = with pkgs; [
    dmenu
    alacritty
    firefox
    xclip
  ];
}
