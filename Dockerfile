FROM microdeb/bullseye

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

ARG APT_OPTS="--no-install-recommends -o APT::Install-Suggests=0 -o Acquire::Languages=none"

RUN apt-get update \
    && apt-get install -y $APT_OPTS ca-certificates wget procps dbus kmod udev git nano \
    systemd systemd-sysv systemd-container \
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

RUN set -eux; \
      { \
        echo 'path-exclude /lib/systemd/system/multi-user.target.wants/*'; \
        echo 'path-exclude /etc/systemd/system/*.wants/*'; \
        echo 'path-exclude /lib/systemd/system/local-fs.target.wants/*'; \
        echo 'path-exclude /lib/systemd/system/sockets.target.wants/*udev*'; \
        echo 'path-exclude /lib/systemd/system/sockets.target.wants/*initctl*'; \
        echo 'path-exclude /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup*'; \
        echo 'path-exclude /lib/systemd/system/systemd-update-utmp*'; \
      } > /etc/dpkg/dpkg.cfg.d/50-no_systemd-files

RUN git clone --depth 1 https://github.com/FrangaL/rpi-img-builder.git /images

WORKDIR /images

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

LABEL maintainer="FrangaL <frangal@gmail.com>" \
  org.label-schema.build-date="$BUILD_DATE" \
  org.label-schema.version="1.0" \
  org.label-schema.docker.schema-version="1.0" \
  org.label-schema.name="rpi-images-builder" \
  org.label-schema.description="Tools to create images for RasPiOS/Debian arm64/armhf for Raspberry Pi" \
  org.label-schema.vcs-ref="$VCS_REF" \
  org.label-schema.vcs-url="$VCS_URL"
