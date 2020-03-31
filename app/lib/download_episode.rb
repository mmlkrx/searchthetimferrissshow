require 'open-uri'
require_relative './file_name'

class DownloadEpisode
  DOWNLOAD_DIR = ENV['RACK_ENV'] == 'test' ? 'tmp/' : 'html_files/episodes/'

  #
  # This method expects a url to a podcast blogpost:
  # 'https://tim.blog/2017/09/13/ray-dalio/'
  #
  def self.call(url)
    FileUtils.mkdir_p(DOWNLOAD_DIR) unless File.directory?(DOWNLOAD_DIR)

    uri       = URI.parse(url)
    file_name = FileName.from_uri(uri)
    file_path = DOWNLOAD_DIR + file_name

    if File.exists?(file_path)
      puts "Already exists: '#{file_path}'"
    else
      File.open(file_path, 'w') do |file|
        puts "Downloading #{uri}"
        URI.open(uri) do |uri|
          file.write(uri.read)
        end
      end
    end
  end
end
