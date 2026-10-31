cd /home/amp/.ampdata/instances/Minecraft-Towny-wiki || exit 1

rsync -a --exclude='.git/' --exclude='deploy/' --exclude='nbproject/' ./ /var/www/modernmc.ca/
chown -R root:www-data /var/www/modernmc.ca
find /var/www/modernmc.ca -type d -exec chmod 755 {} +
find /var/www/modernmc.ca -type f -exec chmod 644 {} +

curl -ksSI --resolve modernmc.ca:443:127.0.0.1 https://modernmc.ca/
