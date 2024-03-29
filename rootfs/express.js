const express = require('express');
const nocache = require('nocache');
const https = require('https');
const fs = require('fs');

const raw = (req, res, buf, encoding) =>{
  req.rawBody = buf.toString(encoding || 'utf8');
};

class Express{  
  #server;

  constructor(){ 
    this.express = express();
    this.express.use(express.raw({verify:raw, limit:(process.env?.MAX_BODY_SIZE || '16MB')}));
    this.express.use(express.json({verify:raw, limit:(process.env?.MAX_BODY_SIZE || '16MB')}));
    this.express.use(express.urlencoded({verify:raw, extended:true, limit:(process.env?.MAX_BODY_SIZE || '16MB')}));
    this.express.use(nocache());
    this.express.set('trust proxy', ['loopback', 'linklocal', 'uniquelocal']);
    this.express.get('/ping', (req, res, next) =>{
      res.status(200).end();
    });
  }

  start(){
    this.#server = https.createServer({
      key:fs.readFileSync('/etc/express/ssl/default.key', 'utf8'),
      cert:fs.readFileSync('/etc/express/ssl/default.crt', 'utf8')
    }, this.express);

    this.#server.on('error', (e) => {
      console.error('exception on express HTTPS server', e);
    });

    this.#server.listen(process.env?.PORT || 8443);
    process.once('SIGTERM', (code) =>{
      this.#server.close();
      process.exit(1);
    });
    
    process.once('SIGINT', (code) =>{
      this.#server.close();
      process.exit(1);
    }); 
  }
}

module.exports = { Express };