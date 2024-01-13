docker compose up -d

docker compose run --rm certbot certonly --webroot --force-renewal --webroot-path=/var/www/certbot/ --dry-run --email yourmail@gmail.com --agree-tos --no-eff-email -d example.com -d www.example.com


docker compose run --rm certbot certonly --webroot --force-renewal --webroot-path=/var/www/certbot/ --email yourmail@gmail.com --agree-tos --no-eff-email -d example.com -d www.example.com

Then you can set cronjob for above command



