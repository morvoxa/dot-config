{ pkgs, ... }: {
  services.displayManager.ly.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.enable = true;
  environment.systemPackages = with pkgs; [
    xfce4-netload-plugin
  ];
}
