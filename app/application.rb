class App < Rack::App
  extend Rack::App::FrontEnd

  namespace '/stfs' do
    get '/' do
      @episodes = FullTextSearch.find_episodes(params['q'])
      render './views/index.html.erb'
    end
  end
end
