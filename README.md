![banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# EXPRESS
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/11notes/docker-EXPRESS)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![size](https://img.shields.io/docker/image-size/11notes/express/5.1.0?color=0eb305)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![version](https://img.shields.io/docker/v/11notes/express/5.1.0?color=eb7a09)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![pulls](https://img.shields.io/docker/pulls/11notes/express?color=2b75d6)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)[<img src="https://img.shields.io/github/issues/11notes/docker-EXPRESS?color=7842f5">](https://github.com/11notes/docker-EXPRESS/issues)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![swiss_made](https://img.shields.io/badge/Swiss_Made-FFFFFF?labelColor=FF0000&logo=data:image/svg%2bxml;base64,PHN2ZyB2ZXJzaW9uPSIxIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGQ9Im0wIDBoMzJ2MzJoLTMyeiIgZmlsbD0iI2YwMCIvPjxwYXRoIGQ9Im0xMyA2aDZ2N2g3djZoLTd2N2gtNnYtN2gtN3YtNmg3eiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==)

Run your Express application rootless and distroless

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [5.1.0](https://hub.docker.com/r/11notes/express/tags?name=5.1.0)
* [stable](https://hub.docker.com/r/11notes/express/tags?name=stable)
* [latest](https://hub.docker.com/r/11notes/express/tags?name=latest)

# REPOSITORIES ☁️
```
docker pull 11notes/express:5.1.0
docker pull ghcr.io/11notes/express:5.1.0
docker pull quay.io/11notes/express:5.1.0
```

# SYNOPSIS 📖
**What can I do with this?** This image will run your Express application distroless and rootless with a default Express class provided at ```/Express.js```.

# VOLUMES 📁
* **/express/var** - Directory of the express application

# EXAMPLE 🧬
## main.js /express/var/main.js
```js
const Express = require('/Express');
const app = new Express();
app.express.get('/', (req, res, next) => {
  res.status(200).json({hello:"world!"});
});
app.start();
```

# COMPOSE ✂️
```yaml
name: "express"
services:
  express:
    image: "11notes/express:5.1.0"
    environment:
      TZ: "Europe/Zurich"
    ports:
      - "8080:8080/tcp"
    restart: "always"
```

# DEFAULT SETTINGS 🗃️
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user name |
| `uid` | 1000 | [user identifier](https://en.wikipedia.org/wiki/User_identifier) |
| `gid` | 1000 | [group identifier](https://en.wikipedia.org/wiki/Group_identifier) |
| `home` | /express | home directory of user docker |
| `port` | 8080 | /Express.js default port |

# ENVIRONMENT 📝
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Will activate debug option for container image and app (if available) | |
| `EXPRESS_MAX_BODY_SIZE` | /Express.js max body size allowed | 16MB |

# SOURCE 💾
* [11notes/express](https://github.com/11notes/docker-EXPRESS)

# PARENT IMAGE 🏛️
> [!IMPORTANT]
>This image is not based on another image but uses [scratch](https://hub.docker.com/_/scratch) as the starting layer.
>The image consists of the following distroless layers that were added:
>* [11notes/distroless](https://github.com/11notes/docker-distroless/blob/master/arch.dockerfile) - contains users, timezones and Root CA certificates
>* [11notes/distroless:curl](https://github.com/11notes/docker-distroless/blob/master/curl.dockerfile) - app to execute HTTP or UNIX requests

# BUILT WITH 🧰
* [express](https://www.npmjs.com/package/express)

# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-express/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-express/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-express/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created 09.04.2025, 09:02:56 (CET)*