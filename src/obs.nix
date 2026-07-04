{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
    ];
  };

  environment.systemPackages = with pkgs; [
    scrcpy
    adb-sync
    android-tools
    kdePackages.kdenlive
    ffmpeg-full
    nautilus
  ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  users.users.mor.extraGroups = [ "adbusers" ];
}
