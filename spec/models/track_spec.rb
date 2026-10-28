require 'rails_helper'

RSpec.describe Track, type: :model do
  it 'FactoryBotが有効であること' do
    expect(build(:track)).to be_valid
  end

  it 'itunes_idがnilを許容しないこと' do
    track = build(:track, itunes_id: nil)
    expect(track).not_to be_valid
  end

  it 'itunes_idが一意であること' do
    create(:track, itunes_id: 12345)
    track = build(:track, itunes_id: 12345)
    expect(track).not_to be_valid
  end

  it 'titleがnilを許容しないこと' do
    track = build(:track, title: nil)
    expect(track).not_to be_valid
  end

  it 'artistがnilを許容しないこと' do
    track = build(:track, artist: nil)
    expect(track).not_to be_valid
  end

  it 'genreがnilを許容しないこと' do
    track = build(:track, genre: nil)
    expect(track).not_to be_valid
  end

  it 'parameterがnilを許容しないこと' do
    track = build(:track, parameter: nil)
    expect(track).not_to be_valid
  end

  it 'analysisがnilを許容しないこと' do
    track = build(:track, analysis: nil)
    expect(track).not_to be_valid
  end
end
