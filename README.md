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
# docker-composer
git clone https://github.com/FrangaL/images-builder.git

cd images-builder

docker-compose --compatibility up -d

# docker run
docker run --privileged -it -v /dev:/dev -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --name rpi-images -h rpi-images --cap-add SYS_ADMIN \
  --tmpfs /tmp --tmpfs /run --tmpfs /run/lock frangal/rpi-images-builder:latest 
```

### Create Raspberry PI image

```bash
docker exec -it rpi-images git pull

docker exec -it rpi-images bash -c "COMPRESS=xz ./rpi-img-builder.sh"

docker exec -it rpi-images sh -c "ls *.img.xz"

docker cp rpi-images:/images/debian-buster-lite-arm64.img.xz .
```
