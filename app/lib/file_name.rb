require 'uri'

class FileName
  def self.from_uri(uri)
    uri.is_a?(URI) ? parsed_uri = uri : parsed_uri = URI.parse(uri)

    file_name = parsed_uri.path.gsub('/', '-').chomp('-')

    "#{file_name[1..-1]}.html"
  end
end
