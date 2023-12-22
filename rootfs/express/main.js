const { Express } = require('/express');
const app = new Express();
app.express.get('/', (req, res, next) => {
  res.json({hello:"world!"});
});

app.start();