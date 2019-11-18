#while [[ 1 -eq 1 ]]; do
#  for i in $(echo /usr/share/backgrounds/budgie/*.jpg); do
#    gsettings set org.gnome.desktop.background picture-uri file:///${i}
#    sleep 5;
#  done
#done

#while [[ 1 -eq 1 ]]; do
#  #for i in $(echo /home/mohamedelsiddig/Pictures/MyWallpaper/NewWallpapers/*.jpg); do
#  for i in $(echo /home/mohamedelsiddig/Pictures/MyWallpaper/NewWallpapers/Catalina/*.jpg); do
#    gsettings set org.gnome.desktop.background picture-uri file:///"${i}"
#    sleep 5;
#  done
#done

h=`date +%H`
if [[ $h -lt 12 && $h -lt 18 ]]; then
  gsettings set org.gnome.desktop.background picture-uri file:///home/mohamedelsiddig/Pictures/MyWallpaper/NewWallpapers/Catalina/Wallpaper-Day.jpg
elif [[ $h -ge 18 && $h -gt 12 ]]; then
  gsettings set org.gnome.desktop.background picture-uri file:///home/mohamedelsiddig/Pictures/MyWallpaper/NewWallpapers/Catalina/Wallpaper-Night.jpg
else
:
fi
