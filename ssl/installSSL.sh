#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


while true; do
    read -p "Enter a domain (example.com) (or 'exit' to finish): " domain

    # Exit loop if user enters 'exit'
    if [ "$domain" == "exit" ]; then
        break
    fi

    read -p "Enter your email (or 'exit' to finish): " email

    # Exit loop if user enters 'exit'
    if [ "$email" == "exit" ]; then
        break
    fi

    # Run Docker Compose command for the entered domain
    docker-compose run --rm certbot certonly --webroot --force-renewal --webroot-path=/var/www/certbot/ --email "$email" --agree-tos --no-eff-email -d "$domain"

    # Store existing crontab in a file
    crontab -l > mycron
    # Check if the cron job already exists in the file
    if ! grep -q "docker compose run --rm certbot certonly --webroot --force-renewal --webroot-path=/var/www/certbot/ --email $email --agree-tos --no-eff-email -d $domain" mycron; then
        # Add the new cron job to the file
        echo "0 0 1 */2 * docker compose run --rm certbot certonly --webroot --force-renewal --webroot-path=/var/www/certbot/ --email $email --agree-tos --no-eff-email -d $domain >> $SCRIPTPATH/certbot.log 2>&1" >> mycron
        echo "" >> mycron
        # Install the modified cron file
        crontab mycron
    fi
    # Remove temporary file
    rm mycron
done


# Store existing crontab in a file
crontab -l > mycron
# Check if the cron job already exists in the file
if ! grep -q "docker compose run --rm certbot renew" mycron; then
    # Add the new cron job to the file
    echo "0 0 3 * * docker compose run --rm certbot renew >> \$SCRIPTPATH/certbot.log 2>&1" >> mycron
    echo "" >> mycron
    # Install the modified cron file
    crontab mycron
fi
# Remove temporary file
rm mycron
