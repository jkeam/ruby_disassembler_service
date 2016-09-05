# Ruby Disassembler Service

A micro-service that disassembles your Ruby code.

## Setup

### Prereq
1.  Docker

### Build Image
Some quick and useful docker commands:
  ```
  # connect to the running instance
  docker exec -it <container id> /bin/bash

  # see all containers
  docker ps -a

  # see all images
  docker images

  # delete container
  docker rm <container id>

  # delete image
  docker rmi <image id>
  ```

#### Ruby 2.1
1.  Build the image from the Dockerfile
  ```
  docker build -t rubybytes/ruby21-diss-service -f ./dockerfiles/ruby21_dockerfile .
  ```

2.  Run docker
  ```
  docker run -p 8021:8021 -d -e ENV_PORT=8021 rubybytes/ruby21-diss-service
  ```

3.  Ensure its running
  ```
  curl -i localhost:8021
  ```

#### Ruby 2.2
1.  Build the image from the Dockerfile
  ```
  docker build -t rubybytes/ruby22-diss-service -f ./dockerfiles/ruby22_dockerfile .
  ```

2.  Run docker
  ```
  docker run -p 8022:8022 -d -e ENV_PORT=8022 rubybytes/ruby22-diss-service
  ```

3.  Ensure its running
  ```
  curl -i localhost:8022
  ```

#### Ruby 2.3
1.  Build the image from the Dockerfile
  ```
  docker build -t rubybytes/ruby23-diss-service -f ./dockerfiles/ruby23_dockerfile .
  ```

2.  Run docker
  ```
  docker run -p 8023:8023 -d -e ENV_PORT=8021 rubybytes/ruby23-diss-service
  ```

3.  Ensure its running
  ```
  curl -i localhost:8023
  ```

