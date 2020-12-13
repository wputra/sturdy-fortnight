# Sinatra Runbook


## Overview
The purpose of this runbook is to walk you through building a Sinatra app with postgres backend. This is a common pattern that we totally use on a regular basis within TNEDO, Inc...


## The steps
1. Install prerequisites
    * Git
    * Docker (v19.03 or later)
    * Docker Compose (v1.21.2 or later)
    * For MacOS user: simply install Docker Desktop: https://hub.docker.com/editions/community/docker-ce-desktop-mac/, it already include Compose.

2. Clone this repo. Sinatra app code exist under `/app` directory. You may interested with `Dockerfile` and `docker-compose.yml`.
   ```
   git clone https://github.com/wputra/sturdy-fortnight.git
   ```
3. Execute `./build-deploy.sh` to start the app. It may take few minutes.

4. Execute `./build-deploy.sh db_load` to load from schema. You only need to **DO IT ONCE**, when database is empty at first time.

5. Sinatra app should run on port 4567


## Usage
Interact with app using `curl`

### POST
```
curl -X POST http://localhost:4567/ -F "name=test1"

for i in $(seq 11 30);do curl -X POST http://localhost:4567/ -F "name=test$i";done
```

### PATCH
```
curl -X PATCH http://localhost:4567/1  -F "name=test100"
```

### DELETE
```
curl -X DELETE http://localhost:4567/1
```


## Useful Tips
1. App code is mounted to `web` docker container. We use `rerun` so the server will recognise code changes without restart.
2. To enter `web` docker container, please do `docker-compose exec web /bin/bash`.
3. To enter `db` docker container, please do `docker-compose exec db /bin/sh`.
