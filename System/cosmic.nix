{ ... }: {
  #services.displayManager.cosmic-greeter.enable = true;
  #services.desktopManager.cosmic.enable = true;
  services.displayManager.ly.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.enable = true;

}
