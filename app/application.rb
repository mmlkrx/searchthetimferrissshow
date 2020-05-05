require 'rack/app'
require 'erb'
require_relative 'lib/full_text_search'

class App < Rack::App
  get '/' do
    query    = params['q'] || ''
    page     = sanitize_page(params['page'])
    episodes = FullTextSearch.find_episodes(query, page)
    template = ERB.new(File.read('/app/app/views/index.html.erb')) # TODO: This will break on systems not using the docker setup

    template.result_with_hash(query: query, episodes: episodes, current_page: page)
  end

  def sanitize_page(page_param)
    page = page_param.to_i.abs
    page == 0 ? page + 1 : page
  end
end
