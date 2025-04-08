${{ content_synopsis }} This image will run your Express application distroless and rootless with a default Express class provided at ```/Express.js```.

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
| `port` | 8080 | /Express.js default port |

${{ content_environment }}
| `EXPRESS_MAX_BODY_SIZE` | /Express.js max body size allowed | 16MB |

${{ content_source }}

${{ content_parent }}

${{ content_built }}

${{ content_tips }}