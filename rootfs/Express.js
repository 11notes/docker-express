const express = require('express');
const nocache = require('nocache');
const http = require('node:http');

const raw = (req, res, buf, encoding) =>{
  req.rawBody = buf.toString(encoding || 'utf8');
};

class Express{
  #server;

  constructor(){ 
    this.express = express();
    this.express.use(express.raw({verify:raw, limit:(process.env?.EXPRESS_MAX_BODY_SIZE || '16MB')}));
    this.express.use(express.json({verify:raw, limit:(process.env?.EXPRESS_MAX_BODY_SIZE || '16MB')}));
    this.express.use(express.urlencoded({verify:raw, extended:true, limit:(process.env?.EXPRESS_MAX_BODY_SIZE || '16MB')}));
    this.express.use(nocache());
    this.express.set('trust proxy', ['loopback', 'linklocal', 'uniquelocal']);
    this.express.get('/ping', (req, res, next) =>{
      res.status(200).end();
    });
  }

  start(){
    this.#server = http.createServer({keepAlive:true}, this.express);

    this.#server.on('error', (e) => {
      console.error('exception on express HTTPS server', e);
    });

    this.#server.listen(process.env?.EXPRESS_PORT || 3000);
    
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

module.exports = Express;