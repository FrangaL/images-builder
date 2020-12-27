FROM debian:buster-slim

LABEL maintainer="FrangaL <frangal@gmail.com>"

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV RPI_IMG_VER_BUILD 1.0.1

ARG APT_OPTS="--no-install-recommends -o APT::Install-Suggests=0 -o Acquire::Languages=none"

RUN echo "deb http://deb.debian.org/debian buster-backports main" >/etc/apt/sources.list.d/backports.list \
    && echo 'APT::Default-Release "stable";' > /etc/apt/apt.conf \
    && apt-get update \
    && apt-get install -y $APT_OPTS ca-certificates wget procps dbus kmod udev git nano libterm-readline-gnu-perl \
    && apt-get install -y $APT_OPTS -t buster-backports systemd systemd-sysv systemd-container qemu-user-static debootstrap \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*.bin \
    /var/lib/dpkg/*-old /var/cache/debconf/*-old

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

RUN git clone https://github.com/FrangaL/rpi-img-builder.git /images

WORKDIR /images

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]

# Build-time metadata as defined at http://label-schema.org
ARG VCS_REF

LABEL org.label-schema.build-date="$BUILD_DATE" \
  org.label-schema.version="$RPI_IMG_VER_BUILD" \
  org.label-schema.docker.schema-version="1.0" \
  org.label-schema.name="rpi-images-builder" \
  org.label-schema.description="Tools to create images Raspberry Pi OS/Debian arm64/armhf for Raspberry Pi" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/FrangaL/images-builder"
