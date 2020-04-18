require 'pdf-reader'

module DataProcessing
  module ExtractTranscriptFromPdf
    REPLACE_NEWLINES_WITH_SINGLE_WHITESPACE = [/\R+/, ' ']
    REPLACE_MULTI_WHITESPACE_WITH_SINGLE_WHITESPACE = [/\s+/, ' ']
    REMOVE_COPYRIGHT_NOTICE = [/Copyright.+Rights Reserved\./, '']
    REMOVE_TITLE = [/The Tim Ferriss Show.+tim\.blog\/podcast/, '']

    def self.call(path:)
      reader = PDF::Reader.new(path)

      total_pages = reader.pages.count

      reader.pages.map.with_index do |page, i|
        puts "Now processing page #{i}/#{total_pages} for pdf: #{File.basename(path)}"
        text = page.text
        text = text.gsub(*REPLACE_NEWLINES_WITH_SINGLE_WHITESPACE)
        text = text.gsub(*REPLACE_MULTI_WHITESPACE_WITH_SINGLE_WHITESPACE)
        text = text.gsub(*REMOVE_COPYRIGHT_NOTICE)
        text = text.gsub(*REMOVE_TITLE)
        text
      end
    end
  end
end
