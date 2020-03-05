class App < Rack::App
  extend Rack::App::FrontEnd

  get '/' do
    @query    = params['q']
    @episodes = FullTextSearch.find_episodes(@query)
    render './views/index.html.erb'
  end
end
