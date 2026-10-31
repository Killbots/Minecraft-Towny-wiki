# Deploy the wiki with the existing NGINX/AMP host

The host already has an NGINX virtual host for `admin.modernmc.ca`, which proxies to AMP at `127.0.0.1:8080`. Keep that file unchanged. The wiki uses its own host names on the same NGINX listeners: `modernmc.ca` is canonical and `www.modernmc.ca` redirects to it.

## Publish the static files

From the wiki checkout, copy the site into a dedicated web root. Exclude the Git metadata and deployment notes:

```sh
sudo install -d -o root -g www-data -m 755 /var/www/modernmc.ca
sudo rsync -a --exclude='.git/' --exclude='deploy/' --exclude='nbproject/' ./ /var/www/modernmc.ca/
sudo chown -R root:www-data /var/www/modernmc.ca
sudo find /var/www/modernmc.ca -type d -exec chmod 755 {} +
sudo find /var/www/modernmc.ca -type f -exec chmod 644 {} +
```

## Add the HTTP virtual host

Install `nginx/modernmc.ca.http.conf` as `/etc/nginx/conf.d/modernmc.ca.conf`, then check and reload NGINX:

```sh
sudo install -m 644 deploy/nginx/modernmc.ca.http.conf /etc/nginx/conf.d/modernmc.ca.conf
sudo nginx -t
sudo systemctl reload nginx
```

The Namecheap records for `@` and `www` must resolve to the public IP, and inbound TCP port 80 must reach this host.

## Issue a certificate

Once `http://modernmc.ca` and `http://www.modernmc.ca` reach this host, request one certificate covering both names:

```sh
sudo certbot certonly --webroot -w /var/www/modernmc.ca -d modernmc.ca -d www.modernmc.ca
```

## Enable HTTPS

Replace the temporary HTTP config with `nginx/modernmc.ca.https.conf`, then check and reload NGINX:

```sh
sudo install -m 644 deploy/nginx/modernmc.ca.https.conf /etc/nginx/conf.d/modernmc.ca.conf
sudo nginx -t
sudo systemctl reload nginx
```

This redirects HTTP and `www` traffic to `https://modernmc.ca`. The existing AMP virtual host remains on `admin.modernmc.ca`.
