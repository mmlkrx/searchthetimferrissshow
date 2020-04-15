require_relative '../../../../../utils/data/data_collection/api'

RSpec.describe DataCollection::Api do
  describe '.get_json' do
    subject { described_class.get_json(url: url) }

    let(:url)           { 'https://tim.blog/wp-json/wp/v2/posts' }
    let(:mock_response) { "[{\"id\":50776},{\"id\":50775}]" }

    before do
      allow(Net::HTTP).to receive(:get) { mock_response }
    end

    it 'returns a parsed response' do
      expect(subject).to eq [{"id"=>50776},{"id"=>50775}]
    end
  end
end
