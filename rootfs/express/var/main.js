const Express = require('/Express');
const app = new Express();
app.express.get('/', (req, res, next) => {
  res.status(200).json({hello:"world!"});
});
app.start();