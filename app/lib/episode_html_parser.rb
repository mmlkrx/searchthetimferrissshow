require 'nokogiri'
require_relative './episode_filter'

class EpisodeHtmlParser
  attr_reader :doc

  def initialize(html_file)
    @doc = Nokogiri::HTML(html_file)
  end

  def extract_title
    doc.css("h1[class='entry-title']").text
  end

  def extract_url
    doc.css("link[rel='canonical']")[0]['href']
  end

  def raw_description
    doc.css("div[class='entry-content']").css('p')
  end

  def filtered_description
    EpisodeFilter.filter_description(raw_description)
  end
end
