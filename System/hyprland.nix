{ pkgs, ... }: {

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    hyprlauncher
    waybar
  ];
}
