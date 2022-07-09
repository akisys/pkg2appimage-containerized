FROM bitnami/minideb:latest

ARG PKG2APPIMAGE_URL="https://github.com/AppImage/pkg2appimage/releases/download/continuous/pkg2appimage-1807-x86_64.AppImage"
ARG APPIMAGETOOL_URL="https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"

RUN set -ex \
    && apt update && apt upgrade -y \
    && apt install -y --no-install-recommends \
         wget \
         curl \
         git \
         file \
         binutils \
         libglib2.0-bin \
         desktop-file-utils \
         graphicsmagick-imagemagick-compat \
         ca-certificates \
         build-essential \
         dumb-init \
         gosu \
         rsync

WORKDIR /tmp
RUN set -ex \
    && wget $PKG2APPIMAGE_URL -O pkg2appimage.ai \
    && chmod +x pkg2appimage.ai \
    && ./pkg2appimage.ai --appimage-extract \
    && mv squashfs-root /opt/pkg2appimage \
    && ln -snf /opt/pkg2appimage/AppRun /usr/local/bin/pkg2appimage

RUN set -ex \
    && wget $APPIMAGETOOL_URL -O appimagetool.ai \
    && chmod +x appimagetool.ai \
    && ./appimagetool.ai --appimage-extract \
    && mv squashfs-root /opt/appimagetool \
    && ln -snf /opt/appimagetool/AppRun /usr/local/bin/appimagetool

# base cleanup
RUN set -ex \
    && mkdir /build \
    && rm -rf /tmp/*.ai \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

RUN set -ex \
    && chmod +x /entrypoint.sh

WORKDIR /build

ENV \
  PUID=\
  PGID=

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]