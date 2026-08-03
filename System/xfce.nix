{ pkgs, ... }: {
  services.displayManager.ly.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
    xclip
  ];
  services.gvfs.enable = true;
  services.udev.enable = true;

}
