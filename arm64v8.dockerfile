# :: Arch
  FROM alpine AS qemu
  ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-aarch64.tar.gz
  RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . && mv qemu-3.0.0+resin-aarch64/qemu-aarch64-static .

# :: Header
	FROM 11notes/node:arm64v8-stable
  COPY --from=qemu qemu-aarch64-static /usr/bin
  ENV APP_VERSION=4.18.2
  ENV APP_ROOT=/node

# :: Run
	USER root

  # :: prepare image
  RUN set -ex; \
    apk add --no-cache \
      openssl; \
    mkdir -p /etc/express/ssl; \
    cd /tmp; \
    npm install --save \
      express@${APP_VERSION} \
      body-parser \
      nocache; \
    mv ./node_modules /; \
    cd /; \
    rm -rf /tmp;

  # :: update image
    RUN set -ex; \
      apk --no-cache upgrade;

  # :: copy root filesystem changes and add execution rights to init scripts
    COPY --chown=1000:1000 ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

  # :: change home path for existing user and set correct permission
    RUN set -ex; \
      usermod -d ${APP_ROOT} docker; \
      chown -R 1000:1000 \
        /etc/express \
        ${APP_ROOT};

# :: Volumes
  VOLUME ["${APP_ROOT}"]

# :: Start
	USER docker
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]