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
    firefox
    alacritty
    gnome-themes-extra
    glib
    kdePackages.dolphin
    kdePackages.kio-extras
    kdePackages.kio-fuse
  ];
  services.gvfs.enable = true;
  programs.dconf.enable = true;
  services.udev.enable = true;

  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
        };
      };
    }
  ];
  environment.etc = {
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name = Adwaita-dark
      gtk-application-prefer-dark-theme = 1
    '';

    # Disarankan tambahkan juga untuk GTK 4
    "xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name = Adwaita-dark
      gtk-application-prefer-dark-theme = 1
    '';
  };

}
