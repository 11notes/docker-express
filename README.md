# Alpine :: Express
![size](https://img.shields.io/docker/image-size/11notes/express/4.18.2?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/express?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/express?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-express?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-express?color=c91cb8)

Run Express based on Alpine Linux. Small, lightweight, secure and fast 🏔️

## Description
Use this image as a base layer to deploy or develop your nodejs application with express. Simply add your code and your package.json to `-v /src/:/express`. You can use the existing express.js class if you want, like this:

```js
const { Express } = require('/express');
const app = new Express();
app.express.get('/', (req, res, next) => {
  res.json({hello:"world!"});
});
app.start();
```

## Volumes
* **/express/app** - Directory of your nodejs express application

## Run
```shell
docker run --name express \
  -p 8443:8443/tcp \
  -v .../app:/express/app \
  -d 11notes/express:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /express | home directory of user docker |

## Parent image
* [11notes/node:stable](https://hub.docker.com/r/11notes/node)

## Built with (thanks to)
* [npm::express](https://www.npmjs.com/package/express)
* [Alpine Linux](https://alpinelinux.org)

## Tips
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)