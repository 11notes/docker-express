# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
  # GLOBAL
  ARG APP_UID=1000 \
      APP_GID=1000

# :: FOREIGN IMAGES
  FROM 11notes/distroless AS distroless
  FROM 11notes/distroless:localhealth AS distroless-localhealth
  FROM 11notes/distroless:node-stable AS distroless-node

# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
# :: EXPRESS
  FROM alpine AS build
  ARG APP_VERSION \
      APP_ROOT

  RUN set -ex; \
    apk --update --no-cache add \
      npm;

  RUN set -ex; \
    mkdir -p /distroless${APP_ROOT}/var;

  RUN set -ex; \
    cd /tmp; \
    npm install --save \
      express@${APP_VERSION} \
      body-parser \
      nocache; \
    mv ./node_modules /distroless;


# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
  # :: HEADER
  FROM scratch

  # :: default arguments
    ARG TARGETPLATFORM \
        TARGETOS \
        TARGETARCH \
        TARGETVARIANT \
        APP_IMAGE \
        APP_NAME \
        APP_VERSION \
        APP_ROOT \
        APP_UID \
        APP_GID \
        APP_NO_CACHE

  # :: default environment
    ENV APP_IMAGE=${APP_IMAGE} \
        APP_NAME=${APP_NAME} \
        APP_VERSION=${APP_VERSION} \
        APP_ROOT=${APP_ROOT}

  # :: multi-stage
    COPY --from=distroless / /
    COPY --from=distroless-localhealth / /
    COPY --from=distroless-node / /
    COPY --from=build /distroless/ /
    COPY ./rootfs --chown=${APP_UID}:${APP_GID} / /

# :: PERSISTENT DATA
  VOLUME ["${APP_ROOT}/var"]

# :: MONITOR
  HEALTHCHECK --interval=5s --timeout=2s --start-period=5s \
    CMD ["/usr/local/bin/localhealth", "http://127.0.0.1:3000/ping", "-I"]

# :: EXECUTE
  USER ${APP_UID}:${APP_GID}
  ENTRYPOINT ["/usr/local/bin/node"]
  CMD ["/express/var/main.js"]