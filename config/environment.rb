require 'nokogiri'
require 'open-uri'
require 'pry'
require 'pg'

require File.expand_path('../../app/lib/download_episode', __FILE__)
require File.expand_path('../../app/lib/episode_filter', __FILE__)
require File.expand_path('../../app/lib/episode_html_parser', __FILE__)
require File.expand_path('../../app/lib/file_name', __FILE__)
require File.expand_path('../../app/lib/nokogiri_helper', __FILE__)

require File.expand_path('../../app/models/episode', __FILE__)
