require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative 'download_episode'

desc 'download episode html files; optionally accepts html file'
task :download_episodes, [:file] do |t, args|
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

  all_episodes = doc.xpath('//p[starts-with(@class, "podcast post")]')

  all_links = all_episodes.map do |episode|
    element = episode.css('a').first
    element.attr('href')
  end

  all_links.each do |link|
    DownloadEpisode.call(link)
  end
end

desc 'start a console'
task :console do
  Pry.start
end