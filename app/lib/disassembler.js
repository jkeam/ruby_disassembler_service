const Promise = require('bluebird');
const exec = require('child_process').execFile;

class Disassembler {

  constructor(options={logger, guid}) {
    this.logger = options.logger;
    this.guid = options.guid;
  }

  run(code, done) {
    return this.disassemble({code})
    .then((obj) => {
      done(obj);
    })
    .catch((obj) => {
      done(obj);
    });
  }

  // disassembles the given source class file
  disassemble(obj) {
    const code = obj.code;
    return new Promise( (resolve, reject) => {
      exec('./app/lib/disassembler.rb', [`$'${code}'`], {shell: '/bin/bash'}, (error, stdout, stderr) => {
        if (error) {
          this.logger.error(`${this.guid}: Error -> ${error}`);
          reject({ errors: error });
        } else if (stderr) {
          this.logger.error(`${this.guid}: Stderr-> ${stderr}`);
          reject({ errors: stderr });
        } else {
          this.logger.verbose(`${this.guid}: Disassembling successful`);
          resolve({ result: stdout });
        }
      });
    });
  }

}

module.exports = Disassembler;
