require_relative '../lib/episode_html_parser'

class Episode
  attr_accessor :title, :url

  def initialize(title:, url:)
    @title           = title
    @url             = url
  end

  def self.new_from_html(html_episode)
    parser = EpisodeHtmlParser.new(html_episode)

    title = parser.extract_title
    url = parser.extract_url

    new(title: title, url: url)
  end
end
