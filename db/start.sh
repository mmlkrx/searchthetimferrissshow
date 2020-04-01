#!/bin/sh

echo Starting postgres db container...

docker run \
  --rm \
  --network stfsnet \
  --name pgserver \
  -d \
  -p 5432:5432 \
  -v ~/tmp/postgres_data_stfs:/var/lib/postgresql/data \
  -e "POSTGRES_USER=stfs" \
  -e "POSTGRES_HOST_AUTH_METHOD=trust" \
  postgres:12.2

echo Done \(container ID `docker ps -f name=pgserver -q`\)
echo Data is persisted at ~/tmp/postgres_data_stfs and
echo will be reusable between changing database containers
