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

Data is extracted from HTML documents. Follow these steps to download new blog posts and seed the database from the resulting files:

1. Download and store html documents for each episode to `html_files/episodes/`
   ```shell
   $ rake download_episodes
   ```
2. Seed the database from the downloaded html files
   ```shell
   $ rake db:schema_load
   $ rake db:seed
   ```
3. Build a [text search document](https://www.postgresql.org/docs/10/static/textsearch-intro.html#textsearch-document) for each entry
   ```shell
   $ rake db:build_ts_documents
   ```

**Trying it out**

Now that everything is set up, inside the app docker container, run `rake server` and open your browser at `localhost:9292` to access the web interface.

**Tests**

Running `rspec` inside the app container will run all unit tests. To verify that all css selectors still work, explicitly run the end-to-end tests `rspec spec/end-to-end/`.
