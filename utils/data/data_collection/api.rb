require 'net/http'
require 'json'

module DataCollection
  module Api
    def self.get_json(url:)
      # TODO: How should query params be handled?
      # TODO: what should happen on Net::HTTP errors or JSON.parse errors?
      uri = URI(url)
      res = Net::HTTP.get(uri)
      JSON.parse(res)
    end
  end
end
