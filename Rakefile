require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative 'download_episode'

desc 'download podcast episode html files'
task :download_episodes do
  doc = Nokogiri::HTML(open('https://tim.blog/podcast/'))

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