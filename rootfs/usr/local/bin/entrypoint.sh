#!/bin/ash
  if [ -z "${1}" ]; then
    if [ ! -f "${APP_ROOT}/ssl/default.crt" ]; then
      echo "default SSL/TLS certificate not found, creating defaults ..."
      openssl req -x509 -newkey rsa:4096 -subj "/C=XX/ST=XX/L=XX/O=XX/OU=XX/CN=express" \
        -keyout "${APP_ROOT}/ssl/default.key" \
        -out "${APP_ROOT}/ssl/default.crt" \
        -days 3650 -nodes -sha256 &> /dev/null
    fi
    
    if [ -f "${APP_ROOT}/app/package.json" ]; then
      echo "found package.json, issuing npm start"
      cd ${APP_ROOT}/app
      npm install
      set -- npm start
    else
      if [ -f "${APP_ROOT}/app/main.js" ]; then
        echo "found main.js, issuing node start"
        set -- "node" ${APP_ROOT}/app/main.js
      fi
    fi
  fi
  
  exec "$@"