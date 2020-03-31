module NokogiriHelper
  extend self

  def find_episode_elements(doc)
    doc.xpath('//p[starts-with(@class, "podcast post")]')
  end

  def extract_url_from_episode_element(element)
    element.css('a').first.attr('href')
  end
end
