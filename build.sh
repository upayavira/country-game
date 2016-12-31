#!/bin/sh

docker build -t odoko/countries .
docker rm -f countries countries-db
docker run --name countries-db -e MYSQL_ROOT_PASSWORD=$DB_PASS -d mysql:5.7
docker run -e DB_PASS=$DB_PASS odoko/countries init-db
docker run -d -e GOOGLE_API_KEY=$GOOGLE_API_KEY --name countries -p 8080:8080 odoko/countries app
