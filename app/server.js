const Disassembler = require('./lib/disassembler');

const winston      = require('winston');
const Busboy       = require('busboy');
const http         = require('http');
const port         = process.env.ENV_PORT || 3000;
const env          = process.env.NODE_ENV || 'dev';
const uuid         = require('uuid/v4');

const createLogger = (winston) => {
  const logger = new (winston.Logger)({
    transports: [
      new (winston.transports.Console)(),
      new (winston.transports.File)({
        filename: `./logs/${env}.log`,
        maxsize: 1000,
        maxFiles: 10
      })
    ]
  });
  logger.level = 'debug';
  return logger;
};
const logger = createLogger(winston);

const handlePost = (req, res) => {
  const guid = uuid();
  logger.debug(`${guid}: Disassembling started at ${new Date()}`);
  const disassembler = new Disassembler(logger);
  const busboy = new Busboy({ headers: req.headers });
  let code = "";

  const writeOutput = (bytecode) => {
    logger.debug(`${guid}: Disassembling finished at ${new Date()}`);
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify(bytecode));
  };

  busboy.on('field', (fieldname, val, fieldnameTruncated, valTruncated, encoding, mimetype) => {
    if (fieldname == 'code') {
      // escape the quote so it doesn't collide with the shell terminator
      code = val.replace(/'/g, "\\'");
      logger.debug(`${guid}: Code -> ${code}`);
    }
  });

  busboy.on('finish', () => {
    disassembler.run(code, writeOutput);
  });

  req.pipe(busboy);
};

const router = (req, res) => {
  if (req.method == 'POST') {
    handlePost(req, res);
  } else {
    logger.debug(`Bounced non-post request: ${req.method} at ${new Date()}`);
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Please submit a post with a json payload.');
  }
};

http.createServer(router).listen(port, '0.0.0.0', () => {
  logger.info(`Server running at http://0.0.0.0:${port}/`);
});
