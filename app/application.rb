class App < Rack::App
  extend Rack::App::FrontEnd

  namespace '/stfs' do
    get '/' do
      @episodes = full_text_search_episodes
      render './views/index.html.erb'
    end
  end

  private

  def full_text_search_episodes
    return if params['q'].nil?

    statement = "search"
    CONN.prepare(statement, "SELECT * FROM episodes WHERE to_tsvector(title || ' ' || description) @@ plainto_tsquery($1);")
    res = CONN.exec_prepared(statement, [params['q']])
    CONN.exec("DEALLOCATE #{statement}")
    res.map do |record|
      Episode.new(
        title: record['title'],
        publishing_date: record['publishing_date'],
        description: record['description']
      )
    end
  end
end
