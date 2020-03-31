require_relative '../../../../app/lib/episode_filter'

RSpec.describe EpisodeFilter do
  describe '.filter_description' do
    subject { described_class.filter_description(description) }

    let(:description) { EpisodeHtmlParser.new(html_file).raw_description }
    let(:html_file) { File.read('spec/fixtures/2017-09-13-ray-dalio.html') }
    let(:filtered_description) { 'Ray Dalio (@raydalio) grew up a middle-class kid from Long Island. He started his investment company Bridgewater Associates out of a two-bedroom apartment at age 26, and it now has roughly $160 billion in assets under management. Over 42 years, he has built Bridgewater into what Fortune considers the fifth most important private company in the U.S. Along the way, Dalio became one the 100 most influential people in the world (according to Time) and one of the 100 wealthiest people in the world (according to Forbes). Because of his unique investment principles that have changed industries, CIO Magazine dubbed him “the Steve Jobs of investing.” Ray believes his success is the result of principles he’s learned, codified, and applied to his life and business. Those principles are detailed in his new book Principles: Life and Work. In this interview, we cover a lot, including: Enjoy! Want to hear a podcast featuring another great investor?  — Listen to this conversation with Naval Ravikant. In this episode, we discuss the habits and behaviors of both highly successful and happy people (stream below or right-click here to download): People are always asking me what I use for cognitive enhancement right now — this is the answer. You can try it right now by going to foursigmatic.com/tim and using the code Tim to get 20 percent off your first order. If you are in the experimental mindset, I do not think you’ll be disappointed.' }

    it 'filters out sponsors, etc.' do
      expect(subject).to eq filtered_description
    end
  end
end
