# Ruby Disassembler Service
[![Build Status](https://travis-ci.org/jkeam/ruby_disassembler_service.svg?branch=master)](https://travis-ci.org/jkeam/ruby_disassembler_service)

A micro-service that disassembles your Ruby code.

## Setup

### Prereq
1.  Docker

### Building
```
docker build -t jkeam/ruby_disassembler30_service -f ./dockerfiles/Dockerfile_ruby30
```

### Running
```
docker run -p 3000:3000 jkeam/ruby_disassembler30_service
```
