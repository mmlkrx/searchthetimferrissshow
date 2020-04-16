require 'open-uri'

module DataCollection
  module BinaryFile
    def self.download_pdf(url:, dest: '')
      dest = dest || DataCollection::Config::DOWNLOAD_DIR_PDF

      URI.open(url) do |io|
        # TODO: How to handle exceptions related to bad url or dest
        file_name = File.basename(io.base_uri.path)
        dest_path = dest + file_name

        if File.exists?(dest_path)
          puts "Already exists: '#{dest_path}'"
        else
          File.open(dest_path, 'wb') do |file|
            file.write(io.read)
          end
        end
      end
    end
  end
end
