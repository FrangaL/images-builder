![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/frangal/rpi-images-builder)
# Docker container to build images


### Download container image

```bash
docker pull frangal/rpi-images-builder:latest
```

### Build container image

```bash
git clone https://github.com/FrangaL/images-builder.git

cd images-builder

docker-compose --compatibility up -d --build
```

### Run container

```bash
git clone https://github.com/FrangaL/images-builder.git

cd images-builder

docker-compose --compatibility up -d
```

### Create Raspberry PI image

```bash
docker exec -it rpi-images git pull

docker exec -it rpi-images bash -c "COMPRESS=xz ./rpi-img-builder.sh"

docker exec -it rpi-images sh -c "ls *.img.xz"

docker cp rpi-images:/images/debian-buster-lite-arm64.img.xz .
```
