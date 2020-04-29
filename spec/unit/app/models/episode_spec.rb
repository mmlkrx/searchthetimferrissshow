require_relative '../../../../app/models/episode'

RSpec.describe Episode do
  subject do
    described_class.new(
      title: title,
      url: url,
    )
  end

  let(:title) { 'Ray Dalio' }
  let(:url)   { 'https://tim.blog/2017/09/13/ray-dalio/' }

  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :url }

  describe '.new_from_html' do
    subject { described_class.new_from_html(html_episode) }

    let(:html_episode) { File.read('spec/fixtures/2017-09-13-ray-dalio.html') }

    it { is_expected.to be_a Episode }

    it 'delegates title to EpisodeHtmlParser' do
      expect_any_instance_of(EpisodeHtmlParser).to receive(:extract_title)
      subject
    end

    it 'delegates url to EpisodeHtmlParser' do
      expect_any_instance_of(EpisodeHtmlParser).to receive(:extract_url)
      subject
    end
  end
end
