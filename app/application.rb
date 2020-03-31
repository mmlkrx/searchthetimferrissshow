require 'rack/app'
require 'rack/app/front_end'
require_relative 'lib/full_text_search'

class App < Rack::App
  extend Rack::App::FrontEnd

  get '/' do
    @query    = params['q']
    @episodes = FullTextSearch.find_episodes(@query)
    render './views/index.html.erb'
  end
end
