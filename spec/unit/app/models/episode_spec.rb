require_relative '../../../../app/models/episode'

RSpec.describe Episode do
  subject do
    described_class.new(
      title: title,
      show_notes_url: show_notes_url,
      transcript: transcript
    )
  end

  let(:title)          { 'Ray Dalio' }
  let(:show_notes_url) { 'https://tim.blog/2017/09/13/ray-dalio/' }
  let(:transcript)     { 'are you smiling?' }

  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :show_notes_url }
  it { is_expected.to respond_to :transcript}
end
