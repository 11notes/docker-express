#!/bin/ash
  if [ -z "${1}" ]; then
    if [ ! -f "/etc/express/ssl/default.crt" ]; then
      elevenLogJSON debug "default SSL/TLS certificate not found, creating defaults ..."
      openssl req -x509 -newkey rsa:4096 -subj "/C=XX/ST=XX/L=XX/O=XX/OU=DOCKER/CN=${APP_NAME}" \
        -keyout "/etc/express/ssl/default.key" \
        -out "/etc/express/ssl/default.crt" \
        -days 3650 -nodes -sha256 &> /dev/null
    fi
    
    if [ -f "${APP_ROOT}/package.json" ]; then
      cd ${APP_ROOT}
      npm install
      elevenDockerImageStart
      set -- npm start
    else
      if [ -f "${APP_ROOT}/main.js" ]; then
        elevenDockerImageStart
        set -- "node" ${APP_ROOT}/main.js
      fi
    fi
  fi
  
  exec "$@"