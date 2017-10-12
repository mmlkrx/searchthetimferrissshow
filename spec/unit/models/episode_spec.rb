require_relative '../../../app/models/episode'

RSpec.describe Episode do
  subject do
    described_class.new(
      title: title,
      publishing_date: publishing_date,
      description: description,
    )
  end

  let(:title)           { 'Ray Dalio' }
  let(:publishing_date) { '2017-09-13' }
  let(:description)     { 'Restless sinner, rest in sin.'}

  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :publishing_date }
  it { is_expected.to respond_to :description }
end
