sudo pacman -S ttf-dejavu ttf-liberation noto-fonts

sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d 
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d

echo "export FREETYPE_PROPERTIES=\"truetype:interpreter-version=40\""| sudo tee -a /etc/profile.d/freetype2.sh > /dev/null 

sudo ln -s "$(pwd)/local.conf" /etc/fonts
