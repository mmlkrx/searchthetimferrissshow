require_relative '../lib/episode_html_parser'

class Episode
  attr_accessor :title, :description, :url

  def initialize(title:, description:, url:)
    @title           = title
    @description     = description
    @url             = url
  end

  def self.new_from_html(html_episode)
    parser = EpisodeHtmlParser.new(html_episode)

    title = parser.extract_title
    description = parser.filtered_description
    url = parser.extract_url

    new(title: title, description: description, url: url)
  end
end
