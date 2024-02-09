# :: Header
	FROM 11notes/node:stable
  ENV APP_VERSION=4.18.2
  ENV APP_NAME="express"
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