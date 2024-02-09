![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🏔️ Alpine - Express
![size](https://img.shields.io/docker/image-size/11notes/express/4.18.2?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/express/4.18.2?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/express?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-express?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-express?color=c91cb8) ![stars](https://img.shields.io/docker/stars/11notes/express?color=e6a50e)

**Run an Express project in comfort and style**

# SYNOPSIS
What can I do with this? This image will provide you an easy method of deploying or developing an express app. Simply place your files and your `package.json` into ` /node` and start the container.

# VOLUMES
* **/node** - Directory of your app

# RUN
```shell
docker run --name express \
  -p 8443:8443/tcp \
  -v .../node:/node \
  -d 11notes/express:[tag]
```

# EXAMPLES
## main.js /node/main.js
```js
const { Express } = require('/express');
const app = new Express();
app.express.get('/', (req, res, next) => {
  res.json({hello:"world!"});
});
app.start();
```

## package.json /node/package.json
```json
{
  "dependencies": {
    "redis": "^4.6.11",
  },
  "name": "REDIS DEMO",
  "version": "1.0.0",
  "main": "main.js",
  "devDependencies": {},
  "scripts": {
    "start": "node main.js"
  },
  "keywords": [],
  "author": "",
  "license": "MIT",
  "description": ""
}
```

# DEFAULT SETTINGS
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /node | home directory of user docker |

# ENVIRONMENT
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Show debug information | |
| `PORT` | express server port (SSL/TLS) | 8443 |

# PARENT IMAGE
* [11notes/node:stable](https://hub.docker.com/r/11notes/node)

# BUILT WITH
* [express](https://expressjs.com)
* [alpine](https://alpinelinux.org)

# TIPS
* Only use rootless container runtime (podman, rootless docker)
* Allow non-root ports < 1024 via `echo "net.ipv4.ip_unprivileged_port_start=53" > /etc/sysctl.d/ports.conf`
* Use a reverse proxy like Traefik, Nginx to terminate TLS with a valid certificate
* Use Let’s Encrypt certificates to protect your SSL endpoints

# ElevenNotes<sup>™️</sup>
This image is provided to you at your own risk. Always make backups before updating an image to a new version. Check the changelog for breaking changes.
    