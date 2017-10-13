require 'nokogiri'

class EpisodeHtmlParser
  attr_reader :doc

  def initialize(html_file)
    @doc = Nokogiri::HTML(html_file)
  end

  def extract_title
    doc.css("h1[class='entry-title']").text
  end

  def extract_publishing_date
    # TODO: infer this from file name, possible put into EpisodeLink class
    #       with file_name.rb. Just store date in db, not datetime.
    doc.css('time').first.attributes['datetime'].value
  end

  def extract_description
    doc.css("div[class='entry-content']").css('p').text
  end
end
