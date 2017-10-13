RSpec.describe FileName do
  describe '.from_uri' do
    subject { described_class.from_uri(uri) }

    let(:uri)                { URI.parse(url) }
    let(:url)                { 'https://tim.blog/2017/09/13/ray-dalio/' }
    let(:expected_file_name) { '2017-09-13-ray-dalio.html' }

    it 'outputs a string with the correct file name' do
      expect(subject).to eq expected_file_name
    end

    context 'when url is missing trailing slash' do
      let(:url) { 'https://tim.blog/2017/09/13/ray-dalio' }

      it 'outputs a string with the correct file name' do
        expect(subject).to eq expected_file_name
      end
    end

    context 'when uri is a plain url' do
      let(:uri) { url }

      it 'outputs a string with the correct file name' do
        expect(subject).to eq expected_file_name
      end
    end
  end
end
