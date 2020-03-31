require_relative '../../../app/models/episode'

RSpec.describe Episode do
  subject do
    described_class.new(
      title: title,
      publishing_date: publishing_date,
      description: description,
      url: url,
    )
  end

  let(:title)           { 'Ray Dalio' }
  let(:publishing_date) { '2017-09-13' }
  let(:description)     { 'Restless sinner, rest in sin.'}
  let(:url)             { 'https://tim.blog/2017/09/13/ray-dalio/' }

  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :publishing_date }
  it { is_expected.to respond_to :description }
  it { is_expected.to respond_to :url }

  describe '#publishing_date' do
    it { expect(subject.publishing_date).to_not be_a DateTime }
    it { expect(subject.publishing_date).to be_a Date }
  end

  describe '.new_from_html' do
    subject { described_class.new_from_html(html_episode) }

    let(:html_episode) { File.read('spec/fixtures/2017-09-13-ray-dalio.html') }

    it { is_expected.to be_a Episode }

    it 'delegates title to EpisodeHtmlParser' do
      expect_any_instance_of(EpisodeHtmlParser).to receive(:extract_title)
      subject
    end

    it 'delegates publishing_date to EpisodeHtmlParser' do
      expect_any_instance_of(EpisodeHtmlParser).to receive(:extract_publishing_date) { '2017-09-13' }
      subject
    end

    it 'delegates description to EpisodeHtmlParser' do
      expect_any_instance_of(EpisodeHtmlParser).to receive(:filtered_description)
      subject
    end

    it 'delegates url to EpisodeHtmlParser' do
      expect_any_instance_of(EpisodeHtmlParser).to receive(:extract_url)
      subject
    end
  end
end
