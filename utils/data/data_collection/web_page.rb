require 'open-uri'

module DataCollection
  module WebPage
    def self.get_html(url:)
      page = URI.open(url)
      content = page.read
    end
  end
end
