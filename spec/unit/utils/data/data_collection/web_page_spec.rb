require_relative '../../../../../utils/data/data_collection/web_page'

RSpec.describe DataCollection::WebPage do
  describe '.get_html' do
    subject { described_class.get_html(url: url) }

    let(:url)          { 'https://dhamma.org' }
    let(:response_obj) { instance_double("StringIO", read: html_body) }
    let(:html_body)    { "<!DOCTYPE html>\n<html>\nBe happy\n</html>" }

    before do
      allow(URI).to receive(:open) { response_obj }
    end

    it 'calls URI.open with the url' do
      expect(URI).to receive(:open).with(url)
      subject
    end

    it 'returns the page content' do
      expect(subject).to eq html_body
    end
  end
end
