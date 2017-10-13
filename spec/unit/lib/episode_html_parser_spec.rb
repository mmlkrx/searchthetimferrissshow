require_relative '../../../app/lib/episode_html_parser'

RSpec.describe EpisodeHtmlParser do
  let(:parser) { described_class.new(html_file) }
  let(:html_file) { File.read('spec/fixtures/2017-09-13-ray-dalio.html') }

  describe '#extract_title' do
    subject { parser.extract_title }

    it 'returns the correct title' do
      expect(subject).to eq 'Ray Dalio, The Steve Jobs of Investing'
    end
  end

  describe '#extract_publishing_date' do
    subject { parser.extract_publishing_date }

    it 'returns the correct publishing date' do
      expect(subject).to eq '2017-09-13T14:21:52+00:00'
    end
  end

  describe '#extract_description' do
    subject { parser.extract_description }

    let(:expected_description) { "“Pain plus reflection equals progress.” \n– Ray DalioRay Dalio (@raydalio) grew up a middle-class kid from Long Island. He started his investment company Bridgewater Associates out of a two-bedroom apartment at age 26, and it now has roughly $160 billion in assets under management. Over 42 years, he has built Bridgewater into what Fortune considers the fifth most important private company in the U.S.Along the way, Dalio became one the 100 most influential people in the world (according to Time) and one of the 100 wealthiest people in the world (according to Forbes). Because of his unique investment principles that have changed industries, CIO Magazine dubbed him “the Steve Jobs of investing.”Ray believes his success is the result of principles he’s learned, codified, and applied to his life and business. Those principles are detailed in his new book Principles: Life and Work.In this interview, we cover a lot, including:Enjoy!Want to hear a podcast featuring another great investor?  — Listen to this conversation with Naval Ravikant. In this episode, we discuss the habits and behaviors of both highly successful and happy people (stream below or right-click here to download):This podcast is brought to you by Four Sigmatic. I reached out to these Finnish entrepreneurs after a very talented acrobat introduced me to one of their products, which blew my mind (in the best way possible). It is mushroom coffee featuring chaga. It tastes like coffee, but there are only 40 milligrams of caffeine, so it has less than half of what you would find in a regular cup of coffee. I do not get any jitters, acid reflux, or any type of stomach burn. It put me on fire for an entire day, and I only had half of the packet.People are always asking me what I use for cognitive enhancement right now — this is the answer. You can try it right now by going to foursigmatic.com/tim and using the code Tim to get 20 percent off your first order. If you are in the experimental mindset, I do not think you’ll be disappointed.This podcast is also brought to you by Athletic Greens. I get asked all the time, “If you could only use one supplement, what would it be?” My answer is, inevitably, Athletic Greens. It is my all-in-one nutritional insurance. I recommended it in The 4-Hour Body and did not get paid to do so. As a listener of The Tim Ferriss Show, you’ll get 30 percent off your first order at AthleticGreens.com/Tim.QUESTION(S) OF THE DAY: What was your favorite quote or lesson from this episode? Please let me know in the comments.Scroll below for links and show notes…Bridgewater Associates | Principles.com | Twitter | FacebookPosted on: September 13, 2017.\n\t\t\t\tPlease check out Tools of Titans, my latest book, which shares the tactics, routines, and habits of billionaires, icons, and world-class performers. It was distilled from more than 10,000 pages of notes, and everything has been vetted and tested in my own life in some fashion. The tips and tricks in Tools of Titans changed my life, and I hope the same for you. Click here for sample chapters, full details, and a Foreword from Arnold Schwarzenegger." }

    it 'returns the correct description' do
      expect(subject).to eq expected_description
    end
  end
end
