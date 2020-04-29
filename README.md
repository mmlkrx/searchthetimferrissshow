## About

This web application allows you to search across every Tim Ferriss Show podcast episode to find information you've heard on the show.

It's a small ruby application with a postgres database that also provides the full text search functionality. Runtime dependencies are kept to a minimum.

## How to run it locally

**Requirements**

The following instructions assume that you have [docker](https://docs.docker.com/get-docker/) installed on your system.

Using docker, we can start a database and application server that run in the same network:

```shell
$ docker network create stfsnet
$ ./db/start.sh
$ docker build -t stfs:latest .
$ docker run --rm --name app --network stfsnet -it -v $(pwd):/app -p 127.0.0.1:9292:9292 stfs:latest /bin/sh
```

**To do anything useful, let's add some data:**

`db/starter_db/` contains a starter database with `title`, `number`, `show_notes_url`, and `transcript` for the first 150 episodes (except for some cases where episodes don't have a transcript or show notes).

To use this data, let's import our database schema:

```shell
$ rake db:schema_load
```

Now let's add the first 150 episodes:

```shell
$ gunzip -c db/starter_db/starter_db_data.gz | psql -h pgserver -U stfs stfs
```

**Hint:** if the current application databases' schema diverts too much from what the data dump expects, just use `db/starter_db/starter_db_schema.sql` instead of `db/schema.sql` and [migrate the data to your current database](https://stackoverflow.com/a/9929608).

The final step is to generate a `tsvector` for every transcript in the database. Without this the search won't work.

```shell
$ rake db:generate_tsvector_for_transcripts
```

**Trying it out**

Now that everything is set up, inside the app docker container, run `rake server` and open your browser at `localhost:9292` to access the web interface.

**Tests**

Running `rspec` inside the app container will run all unit tests. To verify that all css selectors still work, explicitly run the end-to-end tests `rspec spec/end-to-end/`.
