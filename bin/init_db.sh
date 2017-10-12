#!/bin/sh

echo Starting postgres db container

docker run \
  --rm \
  --network stfsnet \
  --name pgserver \
  -d \
  -p 5432:5432 \
  -e "POSTGRES_USER=stfs" \
  postgres:latest
