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
  systemd.user.services.dwm-autostart = {
    description = "DWM Startup Applications";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      PassEnvironment = [
        "DISPLAY"
        "XAUTHORITY"
        "PATH"
      ];

      ExecStart = pkgs.writeScript "dwm-autostart-2026" ''
        #!/bin/sh

        INTERFACE="wlp0s29u1u1"

        OLD_RX=$(cat /proc/net/dev | grep "$INTERFACE" | ${pkgs.gawk}/bin/awk '{print $2}')
        OLD_TX=$(cat /proc/net/dev | grep "$INTERFACE" | ${pkgs.gawk}/bin/awk '{print $10}')

        while true; do
          sleep 1

          NOW_RX=$(cat /proc/net/dev | grep "$INTERFACE" | ${pkgs.gawk}/bin/awk '{print $2}')
          NOW_TX=$(cat /proc/net/dev | grep "$INTERFACE" | ${pkgs.gawk}/bin/awk '{print $10}')

          DOWN=$(( (NOW_RX - OLD_RX) / 1024 ))
          UP=$(( (NOW_TX - OLD_TX) / 1024 ))

          if [ $DOWN -gt 1024 ]; then
              DOWN_STR=$(echo "scale=1; $DOWN / 1024" | ${pkgs.bc}/bin/bc)M/s
          else
              DOWN_STR="''${DOWN}K/s"
          fi

          if [ $UP -gt 1024 ]; then
              UP_STR=$(echo "scale=1; $UP / 1024" | ${pkgs.bc}/bin/bc)M/s
          else
              UP_STR="''${UP}K/s"
          fi

          TIME=$(date +'%H:%M')

          ${pkgs.xsetroot}/bin/xsetroot -name " ⬇️ $DOWN_STR ⬆️ $UP_STR | 🕒 $TIME "

          OLD_RX=$NOW_RX
          OLD_TX=$NOW_TX
        done
      '';
      Restart = "on-failure";
    };
  };

  environment.etc."xdg/autostart/dwm-systemd-trigger.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=DWM Systemd Trigger
    Comment=Trigger systemd graphical session for DWM
    Exec=systemctl --user start graphical-session.target
    OnlyShowIn=dwm;DWM;
    NoDisplay=true
  '';

  environment.systemPackages = with pkgs; [
    dmenu
    alacritty
    firefox
    xclip
    fastfetch
    xsetroot
  ];
}
