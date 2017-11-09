class Episode
  attr_accessor :title, :publishing_date, :description, :url

  def initialize(title:, publishing_date:, description:, url:)
    @title           = title
    @publishing_date = Date.parse(publishing_date)
    @description     = description
    @url             = url
  end

  def self.new_from_html(html_episode)
    parser = EpisodeHtmlParser.new(html_episode)

    title = parser.extract_title
    publishing_date = parser.extract_publishing_date
    description = parser.filtered_description
    url = parser.extract_url

    new(title: title, publishing_date: publishing_date, description: description, url: url)
  end
end
