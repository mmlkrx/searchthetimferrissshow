require 'nokogiri'

module DataProcessing
  module ExtractFromHtml
    def self.with_filter(path:, filter:)
      # TODO: wrap nokogiri
      doc = Nokogiri::HTML(File.read(path))

      res = doc.xpath(filter)

      res.map { |node| node.respond_to?(:attr) ? node.attr('href') : node }
    end
  end
end
