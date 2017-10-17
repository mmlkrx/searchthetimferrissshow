require 'nokogiri'
require 'open-uri'
require 'pry'
require 'pg'
require 'rack/app'
require 'rack/app/front_end'

require File.expand_path('../initializers/database', __FILE__)

require File.expand_path('../../app/lib/download_episode', __FILE__)
require File.expand_path('../../app/lib/episode_filter', __FILE__)
require File.expand_path('../../app/lib/episode_html_parser', __FILE__)
require File.expand_path('../../app/lib/file_name', __FILE__)
require File.expand_path('../../app/lib/nokogiri_helper', __FILE__)

require File.expand_path('../../app/models/episode', __FILE__)

require File.expand_path('../../app/workflows/download_episodes_from_url', __FILE__)
require File.expand_path('../../app/workflows/download_episodes_from_file', __FILE__)

require File.expand_path('../../app/application', __FILE__)
