const express = require('express');
const nocache = require('nocache');
const https = require('https');
const fs = require('fs');
class Express{  
  #server;

  constructor(){ 
    this.express = express();
    this.express.use(express.raw());
    this.express.use(express.json());
    this.express.use(express.urlencoded({extended:true}));
    this.express.use(nocache());
    this.express.set('trust proxy', ['loopback', 'linklocal', 'uniquelocal']);
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
    console.log(`express HTTPS server started on port ${process.env?.PORT || 8443}`);

    process.once('SIGTERM', (code) =>{
      this.#server.close();
      process.exit(code);
    });
    
    process.once('SIGINT', (code) =>{
      this.#server.close();
      process.exit(code);
    }); 
  }
}

module.exports = { Express };