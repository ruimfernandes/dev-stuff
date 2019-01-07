#!/bin/bash

sudo docker run -d \
  -e MONGO_HOST=mongo \
  -e MONGO_PORT=27017 \
  -e MONGO_BACKUP_FILENAME=call-server-db \
  --link github_mongo_1:mongo \
  -v ~/db-backup/:/backup/:rw \
  bwnyasse/docker-mongodb-worker \
  /start.sh -d no-cron
