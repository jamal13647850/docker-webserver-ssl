#!/bin/bash

# Docker network
NETWORK_NAME="nginxnetwork"
if [ ! "$(docker network ls -q -f name=${NETWORK_NAME})" ]; then
    docker network create ${NETWORK_NAME}
    echo "Docker network ${NETWORK_NAME} created."
else
    echo "Docker network ${NETWORK_NAME} already exists."
fi

# Docker volumes
VOLUME_CERTBOT_ETC="certbot-etc"
VOLUME_CERTBOT_WWW="certbot-www"

if [ ! "$(docker volume ls -q -f name=${VOLUME_CERTBOT_ETC})" ]; then
    docker volume create ${VOLUME_CERTBOT_ETC}
    echo "Docker volume ${VOLUME_CERTBOT_ETC} created."
else
    echo "Docker volume ${VOLUME_CERTBOT_ETC} already exists."
fi

if [ ! "$(docker volume ls -q -f name=${VOLUME_CERTBOT_WWW})" ]; then
    docker volume create ${VOLUME_CERTBOT_WWW}
    echo "Docker volume ${VOLUME_CERTBOT_WWW} created."
else
    echo "Docker volume ${VOLUME_CERTBOT_WWW} already exists."
fi


cd webserver
docker compose up -d