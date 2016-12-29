const Service = require('base_disassembler_service');
const Disassembler = require('./lib/disassembler');

const port         = process.env.ENV_PORT || 3000;
const env          = process.env.NODE_ENV || 'dev';
const logLevel = 'info';
const codeFormatter = (code) => {
  // escape the quote so implementst doesn't collide with the shell terminator
  code = code.replace(/'/g, "\\'");
};

const service = new Service({Disassembler, codeFormatter, port, env, logLevel});
service.run();
