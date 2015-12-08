#!/bin/bash

THUMBS="/Thumbs"
PICTURES="/Pictures"

if [ ! -f "/config/www/PhotoShow/config.php" ]; then
echo "fetching photoshow files from github"
git clone https://github.com/thibaud-rohmer/PhotoShow.git /config/www/PhotoShow
sed -i -e "s#$config->photos_dir.\+#$config->photos_dir = \"${PICTURES}\";#" /config/www/PhotoShow/config.php
sed -i -e "s#$config->ps_generated.\+#$config->ps_generated = \"${THUMBS}\";#" /config/www/PhotoShow/config.php
else
echo "checking for updates"
cd /config/www/PhotoShow
git pull
fi

# patch in fixed keyboard.js file
cp /defaults/keyboard.js /config/www/PhotoShow/src/keyboard.js

sed -i -e "s@\$config->timezone.*@\$config->timezone = \"${TZ}\"@g" /config/www/PhotoShow/config.php
chown -R abc:abc /config/www/PhotoShow /Thumbs
