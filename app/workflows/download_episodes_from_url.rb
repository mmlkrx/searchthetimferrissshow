require 'open-uri'
require 'nokogiri'
require_relative '../lib/nokogiri_helper'
require_relative '../lib/download_episode'

class Workflow
  class DownloadEpisodesFromUrl
    def self.call(url)
      doc = Nokogiri::HTML(URI.open(url))

      episodes = find_all_episode_elements_in_html_doc(doc)

      urls = extract_episode_blogpost_urls_from_episode_elements(episodes)

      download_and_store_each_episode_blogpost(urls)
    end

    private

    def self.find_all_episode_elements_in_html_doc(doc)
      NokogiriHelper.find_episode_elements(doc)
    end

    def self.extract_episode_blogpost_urls_from_episode_elements(episodes)
      episodes.map do |episode|
        NokogiriHelper.extract_url_from_episode_element(episode)
      end
    end

    def self.download_and_store_each_episode_blogpost(urls)
      urls.each do |url|
        DownloadEpisode.call(url)
      end
    end
  end
end
