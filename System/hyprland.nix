{ pkgs, ... }: {

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    hyprlauncher
    waybar
    wlogout
    libnotify
    mako
    wl-clipboard-rs
  ];
}
