# Reset pengaturan panel (taskbar)
xfconf-query -c xfce4-panel -p / -r -R

# Reset pengaturan desktop (wallpaper, ikon desktop)
xfconf-query -c xfdesktop -p / -r -R

# Reset pengaturan window manager (tombol close/minimize, tema jendela)
xfconf-query -c xfwm4 -p / -r -R

# Reset pengaturan tampilan (skala, resolusi, tema ikon)
xfconf-query -c xsettings -p / -r -R
