require_relative '../../../../../utils/data/data_collection/web_page'

RSpec.describe DataCollection::WebPage do
  describe '.download_html' do
    subject { described_class.download_html(url: url, dest: 'tmp/') }

    let(:url) { 'https://dhamma.org' }

    before do
      allow(URI).to receive(:open) { 'nothing' }
    end

    it 'calls URI.open with the url' do
      expect(URI).to receive(:open).with(url)
      subject
    end
  end
end
