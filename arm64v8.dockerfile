# :: QEMU
  FROM multiarch/qemu-user-static:x86_64-aarch64 as qemu

# :: Util
  FROM alpine as util

  RUN set -ex; \
    apk add --no-cache \
      git; \
    git clone https://github.com/11notes/util.git;

# :: Header
	FROM --platform=linux/arm64 11notes/node:stable
  COPY --from=qemu /usr/bin/qemu-aarch64-static /usr/bin
  COPY --from=util /util/docker /usr/local/bin
  ENV APP_VERSION=4.21.1
  ENV APP_NAME="express"
  ENV APP_ROOT=/node

# :: Run
	USER root

  # :: prepare image
  RUN set -ex; \
    apk add --no-cache --update \
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
      apk --no-cache --update upgrade;

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

# :: Monitor
  HEALTHCHECK --interval=5s --timeout=2s CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
	USER docker
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]