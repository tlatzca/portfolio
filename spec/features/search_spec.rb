require "rails_helper"

RSpec.describe "検索フォーム", type: :feature do
  before do
    create(:statistic, media_type: "track")
    create(:statistic, media_type: "book")
  end

  it "書籍から探す、がデフォルトで選択されている" do
    visit root_path

    expect(page).to have_checked_field("match_books")
  end

  it "ワードを入力せずに検索すると、バリデーションで弾かれる" do
    visit root_path

    click_button "作品を検索"

    expect(page).to have_current_path(root_path)
  end

  it "書籍から探す、を選んで検索すると、tracksへ遷移する" do
    visit root_path

    choose "match_books"
    fill_in "query", with: "テスト楽曲"
    click_button "作品を検索"

    expect(page).to have_current_path(tracks_path, ignore_query: true)
  end
end
