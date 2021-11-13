# Ruby Disassembler Service
[![Build Status](https://travis-ci.org/jkeam/ruby_disassembler_service.svg?branch=master)](https://travis-ci.org/jkeam/ruby_disassembler_service)

A micro-service that disassembles your Ruby code.

## Setup

### Prereq
1. Docker
2. Ruby 3.0

### Test
```
rake
```

### Building
```
docker build -t jonnyman9/ruby30-diss-service -f ./dockerfiles/Dockerfile_ruby30 .
```

### Running
```
docker run --rm -p 3000:3000 jonnyman9/ruby30-diss-service
```
