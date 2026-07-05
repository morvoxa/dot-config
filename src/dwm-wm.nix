{ pkgs, xlibre-overlay, ... }: {
  imports = [
    xlibre-overlay.nixosModules.overlay-xlibre-xserver
    xlibre-overlay.nixosModules.overlay-xlibre-xf86-input-libinput

  ];
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
    fastfetch
  ];
}
