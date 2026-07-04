{ pkgs, ... }: {
  services.displayManager.ly.enable = true;
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
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
