require 'nokogiri'
require 'open-uri'
require 'pry'
require 'pg'
require_relative 'app/lib/download_episode'
require_relative 'app/lib/nokogiri_helper'

desc 'download episode html files; optionally accepts html file'
task :download_episodes, [:file] do |_, args|
  #
  # By default 'https://tim.blog/podcast/' only lists the 10 latest episodes.
  # To get around this, open the url in your browser and manually load older
  # episodes by clicking on 'LOAD MORE PODCASTS'. Then save the page source as
  # a file and pass its path to the rake task.
  #
  doc = if args.file
          Nokogiri::HTML(File.read(args.file))
        else
          Nokogiri::HTML(open('https://tim.blog/podcast/'))
        end

  all_episodes = NokogiriHelper.find_episode_elements(doc)

  all_links = all_episodes.map do |episode|
    NokogiriHelper.extract_url_from_episode_element(episode)
  end

  all_links.each do |link|
    DownloadEpisode.call(link)
  end
end

desc 'start a console'
task console: ['db:connect'] do
  Pry.start
end

namespace :db do
  #
  # dbname and user are defined by $POSTGRES_USER in ./bin/init_db.sh
  #
  desc 'establish a database connection'
  task :connect do
    @conn ||= PG::Connection.new(
                host: 'pgserver',
                port: 5432,
                dbname: 'stfs',
                user: 'stfs'
              )
  end
end
