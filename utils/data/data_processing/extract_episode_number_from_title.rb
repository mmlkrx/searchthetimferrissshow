module DataProcessing
  module ExtractEpisodeNumberFromTitle
    def self.call(title:)
      if title.match?(/#\d{1,3}/)
        title.match(/#\d{1,3}/)[0][1..-1].to_i
      end
    end
  end
end
