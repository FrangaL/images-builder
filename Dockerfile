FROM debian:buster-slim

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://deb.debian.org/debian buster-backports main" >/etc/apt/sources.list.d/backports.list \
    && echo 'APT::Default-Release "stable";' > /etc/apt/apt.conf \
    && apt-get update \
    && apt-get install -y --no-install-recommends -o APT::Install-Suggests=0 -o Acquire::Languages=none \
    ca-certificates wget procps dbus kmod udev git nano libterm-readline-gnu-perl \
    && apt-get install -y --no-install-recommends -o APT::Install-Suggests=0 -o Acquire::Languages=none \
    -t buster-backports systemd systemd-sysv systemd-container \
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
