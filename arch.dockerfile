# :: Build / express
  FROM alpine AS build
  ARG APP_VERSION
  ARG APP_ROOT
  USER root

  RUN set -ex; \
    apk --update --no-cache add \
      npm; \
    mkdir -p /distroless${APP_ROOT}/var;

  COPY ./rootfs /distroless

  RUN set -ex; \
    cd /tmp; \
    npm install --save \
      express@${APP_VERSION} \
      body-parser \
      nocache; \
    mv ./node_modules /distroless;

# :: Distroless / express
  FROM scratch AS distroless-express
  ARG APP_ROOT
  COPY --from=build /distroless/ /

# :: Distroless / node
  FROM 11notes/node:stable AS distroless-node
  FROM scratch
  COPY --from=node /usr/local/bin/node /usr/local/bin/node

# :: Header
  FROM 11notes/distroless AS distroless
  FROM 11notes/distroless:curl AS distroless-curl
  FROM scratch

  # :: arguments
    ARG TARGETARCH
    ARG APP_IMAGE
    ARG APP_NAME
    ARG APP_VERSION
    ARG APP_ROOT
    ARG APP_UID
    ARG APP_GID

  # :: environment
    ENV APP_IMAGE=${APP_IMAGE}
    ENV APP_NAME=${APP_NAME}
    ENV APP_VERSION=${APP_VERSION}
    ENV APP_ROOT=${APP_ROOT}

  # :: multi-stage
    COPY --from=distroless --chown=${APP_UID}:${APP_GID} / /
    COPY --from=distroless-node --chown=${APP_UID}:${APP_GID} / /
    COPY --from=distroless-curl --chown=${APP_UID}:${APP_GID} / /
    COPY --from=distroless-express --chown=${APP_UID}:${APP_GID} / /

# :: Volumes
  VOLUME ["${APP_ROOT}/var"]

# :: Monitor
  HEALTHCHECK --interval=5s --timeout=2s CMD ["/usr/local/bin/curl", "-kILs", "--fail", "http://192.168.18.200:8080/ping"]

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/node"]
  CMD ["/express/var/main.js"]