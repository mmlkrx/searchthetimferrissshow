require_relative '../../../app/workflows/download_episodes_from_url'
#
# Run this test occasionally to ensure the blogs css hasn't changed
#
RSpec.describe Workflow::DownloadEpisodesFromUrl do
  describe '.call' do
    subject { described_class.call(url) }

    let(:url) { 'https://tim.blog/podcast/' }

    after do
      FileUtils.rm_rf(DownloadEpisode::DOWNLOAD_DIR)
    end

    it 'downloads and stores the latest episodes' do
      subject
      expect(Dir['tmp/*'].size).to eq 10
    end
  end
end
