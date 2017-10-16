class Episode
  attr_accessor :title, :publishing_date, :description

  def initialize(title:, publishing_date:, description:)
    @title           = title
    @publishing_date = Date.parse(publishing_date)
    @description     = description
  end

  def self.new_from_html(html_episode)
    parser = EpisodeHtmlParser.new(html_episode)

    title = parser.extract_title
    publishing_date = parser.extract_publishing_date
    description = parser.filtered_description

    new(title: title, publishing_date: publishing_date, description: description)
  end
end
