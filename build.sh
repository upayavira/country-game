#!/bin/sh

docker build -t odoko/countries .
docker rm -f countries
docker run -d -e GOOGLE_API_KEY=$GOOGLE_API_KEY --name countries -p 8080:8080 odoko/countries
