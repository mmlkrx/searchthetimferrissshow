## About

This web application allows you to search across every Tim Ferriss Show podcast episode to find information you've heard on the show. Including all transcripts.

It's a small ruby application with a postgres database that also provides the full text search functionality.

## How to set up the development environment

To develop and run this app locally, we need to set up the two main pieces: A database docker container that runs a postgresql server with real data, and an application docker container that has the tools to connect to the database, as well as run tests and a webserver. These steps assume some knowledge about docker, ruby, and sql databases.

0. **Requirements**

   Install [docker](https://docs.docker.com/get-docker/) on your computer. When you have docker installed, clone this repo and `cd` into it by running the following command in your terminal:

   ```shell
   $ git clone git@github.com:mmlkrx/searchthetimferrissshow.git && cd searchthetimferrissshow/
   ```

1. **Create a network and start a database container**

   Both containers need to run in the same network to resolve hostnames like `pgserver` to the correct IP address. The database `start.sh` script will pull the official postgresql docker image and start a container with a fresh database `stfs` for user `stfs`.

   In your terminal, run:

   ```shell
   $ docker network create stfsnet
   $ ./db/start.sh
   ```

2. **Build image and start the application container**

   The first step will build a ruby image and install all necessary cli tools and gems. We then start the main application container which we'll use from here on out as our development environment.

   Code is shared between the current directory and the container so source code files can be edited in any editor of choice and corresponding files in the container will be updated.

   ```
   $ docker build -t stfs:latest .
   $ docker run --rm --name app --network stfsnet -it -v $(pwd):/app -p 127.0.0.1:9292:9292 stfs:latest /bin/sh
   ```

3. **Add real data**

   For the app's search to display any results, we need to add data to our database. A starter database is included under `db/starter_db/`. This database contains the first 150 episodes of the podcast with their `title`, `number`, `show_notes_url`, and `transcript`.

   To use this data, let's import our database schema. Inside the app container, run:

   ```shell
   # rake db:schema_load
   ```

   Now let's add the first 150 episodes:

   ```shell
   # gunzip -c db/starter_db/starter_db_data.gz | psql -h pgserver -U stfs stfs
   ```

4. **Make our data searchable**

   [The postgres full text search](https://www.postgresql.org/docs/current/textsearch-intro.html) works by preprocessing text to normalize words, group them, and store them in a sorted array. This sorted array is of type `tsvector` and is stored in a separate column for speedier search results.

   Let's preprocess our `transcript` column and store the resulting text search document in the `transcript_ts` column:

   ```shell
   # rake db:generate_tsvector_for_transcripts
   ```

5. **Trying it out**

   Now that everything is set up, inside the app docker container, run `rake server` and open your browser at `localhost:9292` to access the web interface.

   Tests can be run with `rspec` and an interactive console with `rake console`.
