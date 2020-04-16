require 'open-uri'
require_relative '../data_collection'

module DataCollection
  module WebPage
    def self.download_html(url:, dest: nil)
      dest = dest || DataCollection::Config::DOWNLOAD_DIR_WEB_PAGE
      extension = '.html'

      URI.open(url) do |page|
        # TODO: How to handle exceptions related to bad url or dest
        file_path = page.base_uri.path
        file_name = remove_leading_and_trailing_char(replace_slash_with_dash(file_path)) + extension
        dest_path = dest + file_name

        if File.exists?(dest_path)
          puts "Already exists: '#{dest_path}'"
        else
          File.open(dest_path, 'w') do |file|
            file.write(page.read)
          end
        end
      end
    end

    private

    def self.replace_slash_with_dash(url)
      url.gsub!(/\//, '-')
    end

    def self.remove_leading_and_trailing_char(url)
      url[1..-2]
    end
  end
end
