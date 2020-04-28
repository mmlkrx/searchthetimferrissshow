require 'pry'
require 'pg'
require 'cgi'
require_relative './config/environment'
require_relative './utils/workflows/download_episodes_from_file'
require_relative './utils/workflows/download_episodes_from_url'
require_relative './utils/data/data_collection'
require_relative './utils/data/data_collection/api'
require_relative './utils/data/data_collection/web_page'
require_relative './utils/data/data_collection/binary_file'
require_relative './utils/data/data_processing/extract_url_from_html'
require_relative './utils/data/data_processing/extract_text_from_html'
require_relative './utils/data/data_processing/extract_transcript_from_pdf'
require_relative './utils/data/data_processing/filters'
require_relative './utils/data/data_processing/extract_episode_number_from_title'
require_relative './app/models/episode'

desc 'download episode html files; optionally accepts html file'
task :download_episodes, [:file] do |_, args|
  #
  # By default 'https://tim.blog/podcast/' only lists the 10 latest episodes.
  # To get around this, open the url in your browser and manually load older
  # episodes by clicking on 'LOAD MORE PODCASTS', or use javascript to do it for you ;)
  # setInterval(function () {document.getElementById("load-more-podcasts").click();}, 1000);
  # Then save the page source as a file and pass its path to the rake task.
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

  desc 'takes all pdfs under data/pdfs/ and extracts transcript and episode number'
  task insert_transcript_and_episode_number_from_pdf: :connect do
    # Files were downloaded with DataCollection::BinaryFile.download_pdf
    # Files look like 106-scott-adams.pdf, 01-kevin-rose.pdf
    pdfs = Dir['data/pdfs/*.pdf']

    # This sorts them by number
    sorted = pdfs.sort.map do |path|
      ep_num = File.basename(path)[0..2].to_i
      [ep_num, path]
    end.sort_by{ |ary| ary[0] }

    sorted.each_with_index do |array, i|
      ep_num = array[0]
      path = array[1]
      transcript = DataProcessing::ExtractTranscriptFromPdf.call(path: path).join("\n\n").strip

      puts "Inserting:\n\n#{transcript[0..2000]}"

      @conn.prepare("statement-#{i}", 'INSERT INTO episodes (number, transcript) VALUES ($1, $2)')
      res = @conn.exec_prepared("statement-#{i}", [ep_num, transcript])
    end
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

  desc 'seed database from html files'
  task seed: :connect do
    Dir['html_files/episodes/*'].each_with_index do |file, i|
      begin
        episode = Episode.new_from_html(File.read(file))
        @conn.prepare("statement-#{i}", 'INSERT INTO episodes (title, description, url) VALUES ($1, $2, $3)')
        @conn.exec_prepared("statement-#{i}", [episode.title, episode.description, episode.url])
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
