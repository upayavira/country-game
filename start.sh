#!/bin/sh

CMD=$1

case $CMD in
  init-db)
  while ! mysqladmin ping -h"172.17.0.1" --silent; do
    sleep 1
  done
  cat sql/schema.sql | mysql -uroot -p$DB_PASS -h172.17.0.1
  ./init-db.py
  ;;
  app)
  ./app.py
  ;;
  *)
  echo "Unknown action: $CMD"
  ;;
esac
