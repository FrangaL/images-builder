# Docker container to build images

docker-compose --compatibility up -d --build

docker exec -it rpi-images git pull

docker exec -it rpi-images bash -c "COMPRESS=xz ./rpi-img-builder.sh"

docker cp rpi-images:/images/debian-buster-lite-arm64.img.xz .
