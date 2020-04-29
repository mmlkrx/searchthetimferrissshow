require_relative '../../../../app/lib/episode_html_parser'

RSpec.describe EpisodeHtmlParser do
  let(:parser) { described_class.new(html_file) }
  let(:html_file) { File.read('spec/fixtures/2017-09-13-ray-dalio.html') }

  describe '#extract_title' do
    subject { parser.extract_title }

    it 'returns the correct title' do
      expect(subject).to eq 'Ray Dalio, The Steve Jobs of Investing'
    end
  end

  describe '#extract_url' do
    subject { parser.extract_url }

    it 'returns the episodes blogpost url' do
      expect(subject).to eq 'https://tim.blog/2017/09/13/ray-dalio/'
    end
  end
end
