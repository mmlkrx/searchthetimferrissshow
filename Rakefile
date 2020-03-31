require 'pry'
require 'pg'
require_relative './config/environment'
require_relative './utils/workflows/download_episodes_from_file'
require_relative './utils/workflows/download_episodes_from_url'
require_relative './app/models/episode'

desc 'download episode html files; optionally accepts html file'
task :download_episodes, [:file] do |_, args|
  #
  # By default 'https://tim.blog/podcast/' only lists the 10 latest episodes.
  # To get around this, open the url in your browser and manually load older
  # episodes by clicking on 'LOAD MORE PODCASTS'. Then save the page source as
  # a file and pass its path to the rake task.
  #
  if args.file
    Workflow::DownloadEpisodesFromFile.call(args.file)
  else
    Workflow::DownloadEpisodesFromUrl.call('https://tim.blog/podcast/')
  end
end

desc 'start a console'
task console: ['db:connect'] do
  Pry.start
end

namespace :db do
  #
  # dbname and user are defined by $POSTGRES_USER in ./db/start.sh
  #
  desc 'establish a database connection'
  task :connect do
    @conn ||= PG::Connection.new(
                host: Config::Db.host,
                port: Config::Db.port,
                dbname: Config::Db.name,
                user: Config::Db.user
              )
  end

  desc 'load the table schema'
  task :schema_load do
    system "psql -h #{Config::Db.host} -p #{Config::Db.port} -U #{Config::Db.user} #{Config::Db.name} < db/schema.sql"
  end

  desc 'seed database from html files'
  task seed: :connect do
    Dir['html_files/episodes/*'].each_with_index do |file, i|
      begin
        episode = Episode.new_from_html(File.read(file))
        @conn.prepare("statement-#{i}", 'INSERT INTO episodes (title, publishing_date, description, url) VALUES ($1, $2, $3, $4)')
        @conn.exec_prepared("statement-#{i}", [episode.title, episode.publishing_date, episode.description, episode.url])
        puts "Inserted #{episode.title}"
      rescue PG::UniqueViolation => error
        puts "Already exists: #{episode.title}"
      end
    end
  end

  desc 'build text search documents'
  task build_ts_documents: :connect do
    sql = <<~SQL
      UPDATE episodes SET document =
        setweight(to_tsvector(title), 'A') ||
        setweight(to_tsvector(description), 'B')
      WHERE document IS NULL;
    SQL
    res = @conn.exec(sql)
    p res
  end
end

desc 'start server'
task :server do
  system "puma -b tcp://0.0.0.0:9292 -v config.ru"
end
