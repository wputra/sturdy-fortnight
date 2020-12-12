#!/bin/bash
TAG=$(git rev-parse --short HEAD)
docker build -t wputra/sinatra:$TAG .
docker tag wputra/sinatra:$TAG wputra/sinatra:latest

docker-compose up -d
