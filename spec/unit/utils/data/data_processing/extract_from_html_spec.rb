require_relative '../../../../../utils/data/data_processing/extract_from_html'

RSpec.describe DataProcessing::ExtractFromHtml do
  describe '.with_filter' do
    subject { described_class.with_filter(path: path, filter: filter) }

    let(:path)   { 'spec/fixtures/2017-09-13-ray-dalio.html' }
    let(:filter) { '' }

    context 'bad filter' do
      it 'raises a syntax error' do
        expect{ subject }.to raise_error Nokogiri::XML::XPath::SyntaxError
      end
    end

    context 'non matching filter' do
      let(:filter) { '//a[starts-with(@href, "nothing doing")]' }

      it 'returns an empty array' do
        expect(subject).to eq []
      end
    end

    context 'matching filter for urls' do
      let(:filter) { '//a[starts-with(@href, "https://tim.blog")]' }

      it 'returns an array of url strings' do
        actual = subject
        expect(actual).to be_a Array
        expect(actual.first).to be_a String
        expect(URI.parse(actual.first)).to be_a URI::HTTP
      end
    end
  end
end
