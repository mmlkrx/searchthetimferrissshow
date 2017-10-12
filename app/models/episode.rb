require 'date'

class Episode
  attr_accessor :title, :publishing_date, :description

  def initialize(title:, publishing_date:, description:)
    @title           = title
    @publishing_date = DateTime.parse(publishing_date)
    @description     = description
  end
end
