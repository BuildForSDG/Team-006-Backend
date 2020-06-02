#!/bin/bash

# This is a bash script for automatically creating sequelize models of tables
# Requires one command line argument for table name(s) and .env file
# On command-line run: "./create_model.sh <tablename>" to create model for a given table

if [ -f .env ]; then
  export $(echo $(< .env sed 's/#.*//g'| xargs) | envsubst)
fi

npx sequelize-auto -d "$DB_NAME" -h "$DB_HOST" -u "$DB_USER" -x "$DB_PASSWORD" -e postgres -p "$DB_PORT" -o "./src/api/v1/temp_models" -C -t "$1"