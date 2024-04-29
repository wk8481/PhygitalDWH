!#/bin/bash

docker volume create pgdata

docker run -d \
    --name phygital_server \
    -e POSTGRES_PASSWORD=admin \
    -v pgdata:/var/lib/postgresql/data \
    -p 1430:5432 \
    postgres

docker start phygital_server
