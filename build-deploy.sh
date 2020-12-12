#!/bin/bash
TAG=$(git rev-parse --short HEAD)

build () {
  docker build -t wputra/sinatra:$TAG .
  docker tag wputra/sinatra:$TAG wputra/sinatra:latest
}

deploy () {
  docker-compose up -d
}

migrate () {
  docker-compose run web bundle exec rake db:schema:load
}

build
deploy
