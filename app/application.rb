class App < Rack::App
  extend Rack::App::FrontEnd

  namespace '/stfs' do
    get '/' do
      @query    = params['q']
      @episodes = FullTextSearch.find_episodes(@query)
      render './views/index.html.erb'
    end
  end
end
