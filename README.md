# STFS

This app provides a full text search interface for the Tim Ferriss Show.

## Development

Install docker for your platform and start a new container for development:

```shell
docker build -t stfs:latest .
docker run --rm -it -v $(pwd):/app stfs:latest /bin/sh
```

**Adding data**

Data is extracted from HTML documents. Follow these steps to download new blog posts and seed the database from the resulting files:

1. Download and store html documents for each episode to `html_files/episodes/`
   ```shell
   $ rake download_episodes
   ```
2. Seed the database from the downloaded html files