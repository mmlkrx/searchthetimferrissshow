class EpisodeFilter
  def self.filter_description(description)
    sponsors = filter_sponsors(description)
    sponsors << ["Tools of Titans", "links and show", "Twitter"]
    sponsors.flatten!

    filtered_txt = description.reject{|e| sponsors.any?{|b| e.text.include?(b)}}

    final = description.reject do |e|
      sponsors.any?{|sponsor| e.text.include?(sponsor) }
    end.map(&:text)

    final.reject{|e| e.empty? || e.include?('Posted on:') || e.include?('QUESTION') || e.include?("\n") }.join(' ')
  end

  private

  def self.filter_sponsors(elements)
    elements.map do |e|
      e.text.scan(/((?<=brought to you by)|(?<=sponsored by))(.*?)((?=\.)|(?=,))/)
    end.flatten.reject{|e|e.empty?}.map(&:strip)
  end
end
