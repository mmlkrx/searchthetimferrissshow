require_relative '../../../app/lib/nokogiri_helper'

RSpec.describe NokogiriHelper do
  describe '.find_episode_elements' do
    subject { described_class.find_episode_elements(nokogiri_doc) }

    let(:nokogiri_doc) { Nokogiri::HTML(doc) }
    let(:doc)          { File.read('spec/fixtures/podcast_episodes_index.html') }

    it 'returns a collection of nokogiri elements' do
      expect(subject).to be_a Nokogiri::XML::NodeSet
    end

    it 'finds all episode elements' do
      expect(subject.size).to eq 221
    end
  end

  describe '.extract_url_from_episode_element' do
    subject { described_class.extract_url_from_episode_element(element) }

    let(:element) { Nokogiri::HTML(doc)}
    let(:doc)     { File.read('spec/fixtures/episode_element.html') }

    it 'extracts a valid url' do
      expect(subject).to match URI::regexp
    end
  end
end
