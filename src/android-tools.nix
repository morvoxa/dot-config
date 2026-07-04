{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    adb-sync
    android-tools
  ];
  users.users.mor.extraGroups = [ "adbusers" ];
}
