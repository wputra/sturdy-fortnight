# Sinatra Runbook

## Overview
The purpose of this runbook is to walk you through building a Sinatra app with postgres backend. This is a common pattern that we totally use on a regular basis within TNEDO, Inc...

## The steps
1. Install prerequisites
    * Docker v19.03 or later
    * Docker Compose v1.21.2 or later
2. Clone this repo. Sinatra app code exist under `/app` directory
3. Execute `./build-deploy.sh` to start the app. It may take few minutes.
4. Execute `./build-deploy.sh db_load` to load from schema. You only need to do it when database is empty.
5. Sinatra app should run on port 4567

## Usage
Interact with app using `curl`

### POST
curl -X POST http://127.0.0.1:4567/ -F "name=test1"

### PATCH
curl -X PATCH http://127.0.0.1:4567/1  -F "name=test100"

### DELETE
curl -X DELETE http://127.0.0.1:4567/1

## Useful Tips
1. App code is mounted to `web` docker container. and we use `rerun` so the server will recognise code changes without restart.
2. To enter `web` docker container, please do `docker-compose exec web /bin/bash`.
3. To enter `db` docker container, please do `docker-compose exec db /bin/sh`.
