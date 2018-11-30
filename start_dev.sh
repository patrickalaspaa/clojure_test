#!/bin/bash
echo '** Stopping spotapp **'
docker stop spotapp

echo '** Removing container **'
docker rm spotapp

echo '** Removing image **'
docker rmi spotapp

echo '** Building spotapp image **'
docker build -t spotapp .

echo '** Starting spotapp container **'
docker run \
        --mount type=bind,source="$(pwd)"/backend,target=/home/spotapp \
        --mount type=bind,source="$(pwd)"/web,target=/usr/share/nginx/html \
        --mount type=bind,source="$(pwd)"/web,target=/var/www/html \
        --name spotapp \
        -p 8000:8000 \
        -p 80:90 \
        -it spotapp
