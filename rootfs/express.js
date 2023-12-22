const express = require('express');
const nocache = require('nocache');
const https = require('https');
const fs = require('fs');
class Express{  

  #server;

  constructor(){
    process.once('SIGTERM', (code) =>{
      this.#server.close();
      process.exit(0);
    });
    
    process.once('SIGINT', (code) =>{
      this.#server.close();
      process.exit(0);
    });    
    
    this.express = express();
    this.express.use(express.raw());
    this.express.use(express.json());
    this.express.use(express.urlencoded({extended:true}));
    this.express.use(nocache());
    this.express.set('trust proxy', ['loopback', 'linklocal', 'uniquelocal']);
  }

  start(){
    this.#server = https.createServer({
      key:fs.readFileSync(`${process.env.APP_ROOT}/ssl/default.key`, 'utf8'),
      cert:fs.readFileSync(`${process.env.APP_ROOT}/ssl/default.crt`, 'utf8')
    }, this.express);

    this.#server.listen(process.env.PORT || 8443);
  }
}

module.exports = { Express };