#!/bin/ash
  PORT=${PORT:-8443}
  curl --insecure --max-time 5 -kILs --fail https://localhost:${PORT}/ping