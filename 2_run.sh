#!/bin/bash

UUID=`cat /etc/machine-id`
UUID=1004

echo "############# Redis Server ##############"

docker exec -i redisgears redis-cli --no-auth-warning -a password HSET __{person:1} first_name foo last_name bar age 10 # =${UUID}
docker exec -i redisgears redis-cli --no-auth-warning -a password HSET __{person:2} first_name xxx last_name yyy age 20 # =${UUID}

docker exec -i redisgears redis-cli --no-auth-warning -a password XREAD BLOCK 1000 STREAMS __{person:1}${UUID} 0-0 

docker exec -i redisgears redis-cli --no-auth-warning -a password HGETALL person:1

echo "############# MySQL Server ##############"

PGPASSWORD='Password123!' docker exec -i postgres psql -d test -U demouser -c "select * from persons;"
