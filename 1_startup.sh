#!/bin/bash

docker-compose down
docker-compose build
docker-compose up -d

sleep 10

PGPASSWORD='Password123!' docker exec -i postgres psql -d test -U demouser -c "create table persons ( person_id varchar(100) NOT NULL primary key, first varchar(100) NOT NULL, last varchar(100) NOT NULL, age int NOT NULL);"

