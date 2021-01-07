![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/frangal/rpi-images-builder)
# Docker container to build images


### Download container image

```bash
docker push frangal/rpi-images-builder:latest
docker-compose --compatibility up -d

```

### Build container image

```bash
docker-compose --compatibility up -d --build
```

### Create Raspberry PI image

```bash
docker exec -it rpi-images git pull

docker exec -it rpi-images bash -c "COMPRESS=xz ./rpi-img-builder.sh"

docker cp rpi-images:/images/debian-buster-lite-arm64.img.xz .
