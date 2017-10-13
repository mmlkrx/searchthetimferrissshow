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

  describe '#raw_description' do
    subject { parser.raw_description }

    it 'returns a node set ' do
      expect(subject).to be_a Nokogiri::XML::NodeSet
    end

    it 'returns a node set with <p> as the first element' do
      expect(subject.first.name).to eq 'p'
    end
  end

  describe '#filtered_description' do
    subject { parser.filtered_description }

    it 'delegates to EpisodeFilter' do
      expect(EpisodeFilter).to receive(:filter_description)
      subject
    end
  end
end
