# Docker container to build images

docker-compose --compatibility up -d --build

docker exec -it rpi-images git pull
