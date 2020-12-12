#!/bin/bash
TAG=$(git rev-parse --short HEAD)

build () {
  echo "building..."
  docker build -t wputra/sinatra:$TAG .
  docker tag wputra/sinatra:$TAG wputra/sinatra:latest
}

deploy () {
  echo "deploying..."
  docker-compose up -d
}

db_migrate () {
  echo "migrating database..."
  docker-compose run web bundle exec rake db:create
  docker-compose run web bundle exec rake db:migrate
}

db_load () {
  echo "loading database..."
  docker-compose run web bundle exec rake db:create
  docker-compose run web bundle exec rake db:schema:load
}

# main
if [ $# -lt 1 ]; then
  build
  deploy
else
  $1
fi
