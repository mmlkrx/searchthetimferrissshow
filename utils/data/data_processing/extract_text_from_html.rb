module DataProcessing
  module ExtractTextFromHtml
    def self.with_filter(path:, filter:)
      doc = Nokogiri::HTML(File.read(path))

      res = doc.xpath(filter)

      res.map { |node| node.respond_to?(:text) ? node.text : node }
    end
  end
end
