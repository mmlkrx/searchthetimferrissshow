require_relative '../../../../../utils/data/data_collection/binary_file'

RSpec.describe DataCollection::BinaryFile do
  describe '.download_pdf' do
    subject { described_class.download_pdf(url: url, dest: dest) }

    let(:url)  { 'https://dhamma.org' }
    let(:dest) { 'tmp/' }

    before do
      allow(URI).to receive(:open) { 'nothing' }
    end

    it 'calls URI.open with the url' do
      expect(URI).to receive(:open).with(url)
      subject
    end
  end
end
