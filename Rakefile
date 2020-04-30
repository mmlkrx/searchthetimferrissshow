require 'pry'
require 'pg'
require 'cgi'
require_relative './config/environment'
require_relative './utils/data/data_collection'
require_relative './utils/data/data_collection/api'
require_relative './utils/data/data_collection/web_page'
require_relative './utils/data/data_processing/extract_url_from_html'
require_relative './utils/data/data_processing/extract_text_from_html'
require_relative './utils/data/data_processing/filters'
require_relative './utils/data/data_processing/extract_episode_number_from_title'
require_relative './app/models/episode'

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

  desc 'add the show notes url and title to a specific episode'
  task add_show_notes_url_and_title_to_episode: :connect do
    # TODO: paginate this automatically or pass argument to get the latest 10
    url = 'https://tim.blog/wp-json/wp/v2/posts/?per_page=10&page=13&categories=40&order=asc&orderby=date'

    episodes = DataCollection::Api.get_json(url: url)

    episodes.each_with_index do |episode, i|
      title = CGI.unescapeHTML(episode.dig('title', 'rendered'))
      num = DataProcessing::ExtractEpisodeNumberFromTitle.call(title: title)
      url = episode.dig('link')

      puts "#{num}: #{title}"
      puts "url: #{url}\nInsert?"
      answer = STDIN.gets.chomp
      # TODO: this will have to work automatically at some point
      if answer == 'y'
        puts "Inserting.."
        @conn.prepare("statement-#{i}", 'UPDATE episodes SET title = $1, show_notes_url = $2 WHERE number = $3')
        res = @conn.exec_prepared("statement-#{i}", [title, url, num])
      else
        puts "\nSkipping...#{title}\n\n"
      end
    end
  end

  desc 'add transcript from html files'
  task add_transcript: :connect do
    html_files = Dir['data/web_pages/*.html']

    html_files.each_with_index do |path, i|
      transcript = DataProcessing::ExtractTextFromHtml.with_filter(path: path, filter: DataProcessing::Filters::TRANSCRIPT_HTML_TEXT).join("\n\n")
      title = DataProcessing::ExtractTextFromHtml.with_filter(path: path, filter: DataProcessing::Filters::EPISODE_TITLE)[0]
      ep_num = DataProcessing::ExtractEpisodeNumberFromTitle.call(title: title)
      @conn.prepare("statement-#{i}", 'UPDATE episodes SET transcript = $1 WHERE number = $2')
      res = @conn.exec_prepared("statement-#{i}", [transcript, ep_num])
    end
  end

  desc 'build text search documents for every transcript'
  task generate_tsvector_for_transcripts: :connect do
    sql = <<~SQL
      UPDATE episodes SET transcript_ts =
        setweight(to_tsvector(title), 'A') ||
        setweight(to_tsvector(coalesce(transcript, '')), 'B')
      WHERE transcript_ts IS NULL; # TODO: Why only where transcript_ts is null?
    SQL
    res = @conn.exec(sql)
    p res
  end
end

desc 'start server'
task :server do
  system "puma -b tcp://0.0.0.0:9292 -v config.ru"
end
