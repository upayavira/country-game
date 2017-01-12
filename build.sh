#!/bin/sh

docker build -t odoko/countries .
docker rm -f countries 

if [ ! -z $DB ]; then
  docker rm -f countries-db init-db
  echo "Starting database..."
  docker run --name countries-db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$DB_PASS -d mysql:5.7
  echo "Initialising database..."
  docker run --name init-db -e DB_PASS=$DB_PASS odoko/countries init-db
fi

docker run  \
           -e GOOGLE_API_KEY=$GOOGLE_API_KEY \
	   -e FLASK_DEBUG=$FLASK_DEBUG \
           --name countries \
	   -p 8080:8080 \
	   odoko/countries app
