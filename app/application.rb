class App < Rack::App
  extend Rack::App::FrontEnd

  get '/' do
    render './views/index.html'
  end
end
