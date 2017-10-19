class App < Rack::App
  extend Rack::App::FrontEnd

  namespace '/stfs' do
    get '/' do
      if !params['q'].nil?
        res = CONN.exec("SELECT * FROM episodes WHERE to_tsvector(title || '. ' || description) @@ plainto_tsquery('#{params['q']}');") # TODO: NEVER STRING INTERPOLATE USERINPUT DIRECTLY IN A DATABASE QUERY
        @episodes = res.map{|record| Episode.new(title: record['title'], publishing_date: record['publishing_date'], description: record['description'])}
      end
      render './views/index.html.erb'
    end
  end
end
