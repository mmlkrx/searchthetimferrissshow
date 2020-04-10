require 'rack/app'
require 'erb'
require_relative 'lib/full_text_search'

class App < Rack::App
  get '/' do
    query    = params['q']
    episodes = FullTextSearch.find_episodes(query)
    template = ERB.new(File.read('/app/app/views/index.html.erb')) # TODO: This will break on systems not using the docker setup

    template.result_with_hash(query: query, episodes: episodes)
  end
end
