# STFS

This app provides a full text search interface for the Tim Ferriss Show.

## Development

The app needs a running postgres server. Using docker we can start a database and application server that run in the same network:

```shell
$ docker network create stfsnet
$ ./bin/init_db.sh
$ docker build -t stfs:latest .
$ docker run --rm --network stfsnet --name app -it -v $(pwd):/app stfs:latest /bin/sh
```

To play around with the code, use `rake console`.

**Testing**

Running `rspec` inside the running container will run all unit tests. To verify that all css selectors still work, explicitly run the integration tests `rspec spec/integration/`.

**Adding data**

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

## Usage

Follow the instructions in the development section to get a running database and development container running. From the development container shell run `rake server` and open your browser at `localhost:9292` to access the web interface.
