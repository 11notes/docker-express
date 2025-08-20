${{ content_synopsis }} This image will run your Express application distroless and rootless with a default Express class provided at ```/Express.js```.

${{ content_uvp }} Good question! Because ...

${{ github:> [!IMPORTANT] }}
${{ github:> }}* ... this image runs [rootless](https://github.com/11notes/RTFM/blob/main/linux/container/image/rootless.md) as 1000:1000
${{ github:> }}* ... this image has no shell since it is [distroless](https://github.com/11notes/RTFM/blob/main/linux/container/image/distroless.md)
${{ github:> }}* ... this image is auto updated to the latest version via CI/CD
${{ github:> }}* ... this image has a health check
${{ github:> }}* ... this image runs read-only
${{ github:> }}* ... this image is automatically scanned for CVEs before and after publishing
${{ github:> }}* ... this image is created via a secure and pinned CI/CD process
${{ github:> }}* ... this image is very small

If you value security, simplicity and optimizations to the extreme, then this image might be for you.

${{ content_comparison }}

${{ title_volumes }}
* **${{ json_root }}/var** - Directory of the express application

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

${{ content_compose }}

${{ content_defaults }}

${{ content_environment }}
| `EXPRESS_PORT` | port of Express | 3000 |
| `EXPRESS_MAX_BODY_SIZE` | /Express.js max body size allowed | 16MB |

${{ content_source }}

${{ content_parent }}

${{ content_built }}

${{ content_tips }}