require_relative '../lib/episode_html_parser'

class Episode
  attr_accessor :title, :show_notes_url

  def initialize(title:, show_notes_url:)
    @title          = title
    @show_notes_url = show_notes_url
  end

  def self.new_from_html(html_episode)
    parser = EpisodeHtmlParser.new(html_episode)

    title = parser.extract_title
    show_notes_url = parser.extract_url

    new(title: title, show_notes_url: show_notes_url)
  end
end
