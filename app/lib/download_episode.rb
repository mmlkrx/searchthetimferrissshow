require 'open-uri'
require 'fileutils'

class DownloadEpisode
  DOWNLOAD_DIR = 'html_files/episodes/'

  #
  # This method expects a link like this:
  # 'https://tim.blog/2017/09/13/ray-dalio/'
  #
  def self.call(link)
    FileUtils.mkdir_p(DOWNLOAD_DIR) unless File.directory?(DOWNLOAD_DIR)
    
    uri       = URI.parse(link)
    file_name = uri.path.gsub('/', '-')[1..-2]
    file_path = DOWNLOAD_DIR + "#{file_name}.html"
    
    if File.exists?(file_path)
      puts "Already exists: '#{file_path}'"
    else
      open(file_path, 'wb') do |file|
        puts "Downloading #{uri}"
        open(uri) do |uri|
          file.write(uri.read)
        end
      end
    end
  end
end