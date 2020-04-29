class Episode
  attr_accessor :title, :show_notes_url, :transcript

  def initialize(title:, show_notes_url:, transcript:)
    @title          = title
    @show_notes_url = show_notes_url
    @transcript     = transcript
  end
end
