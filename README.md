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
   ```
   % curl localhost:4567 -I

   HTTP/1.1 200 OK
   Content-Type: application/json
   Content-Length: 2
   X-Content-Type-Options: nosniff
   Server: WEBrick/1.6.0 (Ruby/2.7.2/2020-10-01)
   Date: Sun, 13 Dec 2020 00:43:16 GMT
   Connection: Keep-Alive
   ```


## Usage
Interact with app using `curl`

### POST
```
% curl -X POST http://localhost:4567/ -F "name=test1"

% for i in $(seq 11 30);do curl -X POST http://localhost:4567/ -F "name=test$i";done
```

### PATCH
```
% curl -X PATCH http://localhost:4567/1  -F "name=test100"
```

### DELETE
```
% curl -X DELETE http://localhost:4567/1
```


## Useful Tips
1. App code is mounted to `web` docker container. We use `rerun` so the server will recognise code changes without restart.
2. To enter `web` docker container, please do `docker-compose exec web /bin/bash`.
3. To enter `db` docker container, please do `docker-compose exec db /bin/sh`.

## Add more column to a table
1. Create new migration file, under `./app/db/migration/` folder
   ```
   % docker-compose exec web /bin/bash

   root@2311df322979:/app# bundle exec rake db:create_migration NAME=add_location_to_resources
   db/migrate/20201219010643_add_location_to_resources.rb

   root@2311df322979:/app# exit
   ```
2. Modify newly created migration file
   ```
   class AddLocationToResources < ActiveRecord::Migration[6.1]
     def change
       add_column :resources, :location, :string
     end
   end
   ```
3. Execute `./build-deploy.sh db_migrate` to apply the changes. This command also will adjust the schema
   ```
   migrating database...
   Database 'sinatra' already exists
   == 20201219010643 AddLocationToResources: migrating ===========================
   -- add_column(:resources, :location, :string)
      -> 0.0074s
   == 20201219010643 AddLocationToResources: migrated (0.0077s) ==================
   ```
4. Check the db.
   ```
   % docker-compose exec db /bin/sh

   / # psql -U sinatra
   psql (12.5)
   Type "help" for help

   sinatra=# \l
                                  List of databases
      Name    |  Owner  | Encoding |  Collate   |   Ctype    |  Access privileges
   -----------+---------+----------+------------+------------+---------------------
    postgres  | sinatra | UTF8     | en_US.utf8 | en_US.utf8 |
    sinatra   | sinatra | UTF8     | en_US.utf8 | en_US.utf8 |
    template0 | sinatra | UTF8     | en_US.utf8 | en_US.utf8 | =c/sinatra         +
              |         |          |            |            | sinatra=CTc/sinatra
    template1 | sinatra | UTF8     | en_US.utf8 | en_US.utf8 | =c/sinatra         +
              |         |          |            |            | sinatra=CTc/sinatra
   (4 rows)

   sinatra=# \c sinatra
   You are now connected to database "sinatra" as user "sinatra".

   sinatra=# \dt
                   List of relations
    Schema |         Name         | Type  |  Owner
   --------+----------------------+-------+---------
    public | ar_internal_metadata | table | sinatra
    public | resources            | table | sinatra
    public | schema_migrations    | table | sinatra
   (3 rows)

   sinatra=# select * from resources;
    id |  name  |         created_at         |         updated_at         | location
   ----+--------+----------------------------+----------------------------+----------
     1 | test21 | 2020-12-12 14:49:11.184652 | 2020-12-12 14:49:11.184652 |
     2 | test22 | 2020-12-12 14:49:11.197838 | 2020-12-12 14:49:11.197838 |
     3 | test23 | 2020-12-12 14:49:11.21198  | 2020-12-12 14:49:11.21198  |
     4 | test24 | 2020-12-12 14:49:11.230775 | 2020-12-12 14:49:11.230775 |
     5 | test25 | 2020-12-12 14:49:11.246859 | 2020-12-12 14:49:11.246859 |
     6 | test26 | 2020-12-12 14:49:11.261876 | 2020-12-12 14:49:11.261876 |
     7 | test27 | 2020-12-12 14:49:11.281857 | 2020-12-12 14:49:11.281857 |
     8 | test28 | 2020-12-12 14:49:11.296511 | 2020-12-12 14:49:11.296511 |
     9 | test29 | 2020-12-12 14:49:11.30978  | 2020-12-12 14:49:11.30978  |
    10 | test30 | 2020-12-12 14:49:11.326953 | 2020-12-12 14:49:11.326953 |
   (10 rows)
   ```
