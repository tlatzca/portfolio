require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'FactoryBotが有効であること' do
    expect(build(:book)).to be_valid
  end

  it 'isbnがnilを許容しないこと' do
    book = build(:book, isbn: nil)
    expect(book).not_to be_valid
  end

  it 'isbnが一意であること' do
    create(:book, isbn: "9784041000001")
    book = build(:book, isbn: "9784041000001")
    expect(book).not_to be_valid
  end

  it 'titleがnilを許容しないこと' do
    book = build(:book, title: nil)
    expect(book).not_to be_valid
  end

  it 'authorがnilを許容しないこと' do
    book = build(:book, author: nil)
    expect(book).not_to be_valid
  end

  it 'genreがnilを許容しないこと' do
    book = build(:book, genre: nil)
    expect(book).not_to be_valid
  end

  it 'parameterがnilを許容しないこと' do
    book = build(:book, parameter: nil)
    expect(book).not_to be_valid
  end

  it 'analysisがnilを許容しないこと' do
    book = build(:book, analysis: nil)
    expect(book).not_to be_valid
  end
end
