#!/bin/bash

# curl --data @code.json -X "Content-Type: application/json" -X POST localhost:3000

# 200 requests, concurrency 50
hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:3000 > redis0.txt
hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:3000 > redis1.txt
hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:3000 > redis2.txt
hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:3000 > redis3.txt
hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:3000 > redis4.txt
echo "done with redis"

hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:4000 > no_redis0.txt
hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:4000 > no_redis1.txt
hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:4000 > no_redis2.txt
hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:4000 > no_redis3.txt
hey -n 1000 -c 200 -m POST -T "application/json" -D code.json http://localhost:4000 > no_redis4.txt
