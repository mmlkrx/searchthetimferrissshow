require 'uri'

class FileName
  def self.from_url(url)
    uri       = URI.parse(url)
    file_name = uri.path.gsub('/', '-').chomp('-')

    "#{file_name[1..-1]}.html"
  end
end