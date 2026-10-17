# db/seeds.rb

puts "Cleaning database..."
Track.destroy_all
Book.destroy_all

puts "Creating tracks (10 items)..."
tracks = [
  {
    itunes_id: 956479337,
    spotify_id: nil,
    genre: "Indie Rock",
    details: {
      title: "Amber Avenue",
      artist: "The Pale Lanterns",
      release_date: "2024-05-12",
      tempo: "120",
      mood: "melancholic"
    },
    parameter: "[0.85, 0.20, 0.65, 0.40]",
    z_score: "[0.50, -0.30, 0.20, 0.10]"
  },
  {
    itunes_id: 272283435,
    spotify_id: nil,
    genre: "Ambient / Drone",
    details: {
      title: "Cave Salamander",
      artist: "Subterranean Echoes",
      release_date: "2023-11-04",
      tempo: "65",
      mood: "dark"
    },
    parameter: "[0.10, 0.90, 0.80, 0.15]",
    z_score: "[-0.80, 0.90, 0.70, -0.60]"
  },
  {
    itunes_id: 1374169593,
    spotify_id: nil,
    genre: "Post-Rock",
    details: {
      title: "Guernica's Rain",
      artist: "Monochrome Canvas",
      release_date: "2025-02-20",
      tempo: "140",
      mood: "intense"
    },
    parameter: "[0.40, 0.75, 0.30, 0.85]",
    z_score: "[-0.10, 0.60, -0.50, 0.90]"
  },
  {
    itunes_id: 1374170040,
    spotify_id: nil,
    genre: "Minimalist",
    details: {
      title: "Monochrome Glass",
      artist: "Vitreous Cycle",
      release_date: "2023-08-15",
      tempo: "80",
      mood: "cold"
    },
    parameter: "[0.30, 0.60, 0.90, 0.20]",
    z_score: "[-0.30, 0.30, 0.80, -0.40]"
  },
  {
    itunes_id: 375865138,
    spotify_id: nil,
    genre: "Synthwave",
    details: {
      title: "Neon Nocturne",
      artist: "Midnight Transit",
      release_date: "2024-10-30",
      tempo: "115",
      mood: "nostalgic"
    },
    parameter: "[0.70, 0.40, 0.50, 0.60]",
    z_score: "[0.30, -0.10, 0.00, 0.30]"
  },
  {
    itunes_id: 1374169655,
    spotify_id: nil,
    genre: "Folk",
    details: {
      title: "Paper Lanterns",
      artist: "The Paper Kites",
      release_date: "2022-04-18",
      tempo: "95",
      mood: "warm"
    },
    parameter: "[0.80, 0.15, 0.70, 0.25]",
    z_score: "[0.40, -0.40, 0.30, -0.30]"
  },
  {
    itunes_id: 1374169596,
    spotify_id: nil,
    genre: "Ambient",
    details: {
      title: "Subterranean Drift",
      artist: "Deep Resonance",
      release_date: "2024-01-10",
      tempo: "50",
      mood: "hypnotic"
    },
    parameter: "[0.05, 0.95, 0.95, 0.05]",
    z_score: "[-0.90, 0.95, 0.90, -0.80]"
  },
  {
    itunes_id: 1374169697,
    spotify_id: nil,
    genre: "Industrial",
    details: {
      title: "Rust & Velvet",
      artist: "Velvet Industrial",
      release_date: "2023-09-05",
      tempo: "130",
      mood: "heavy"
    },
    parameter: "[0.35, 0.85, 0.40, 0.80]",
    z_score: "[-0.20, 0.75, -0.30, 0.80]"
  },
  {
    itunes_id: 956479333,
    spotify_id: nil,
    genre: "Lo-Fi / Chillhop",
    details: {
      title: "Forgotten Frequencies",
      artist: "Static Memory",
      release_date: "2024-07-22",
      tempo: "85",
      mood: "dusty"
    },
    parameter: "[0.60, 0.30, 0.75, 0.30]",
    z_score: "[0.10, -0.20, 0.40, -0.20]"
  },
  {
    itunes_id: 1374169692,
    spotify_id: nil,
    genre: "New Age",
    details: {
      title: "Silent Archipelago",
      artist: "Isle of Silence",
      release_date: "2025-03-01",
      tempo: "70",
      mood: "serene"
    },
    parameter: "[0.50, 0.10, 0.95, 0.10]",
    z_score: "[0.00, -0.50, 0.90, -0.70]"
  }
]

tracks.each do |track_attrs|
  Track.create!(track_attrs)
end
puts "#{Track.count} tracks created."

puts "Creating books (10 items)..."
books = [
  {
    isbn: "9784150315061",
    genre: "ノンフィクション / 人類学",
    details: {
      title: "最期の言葉の村へ：消滅危機言語タヤップを話す人々との30年",
      author: "ドン・クリック",
      release_date: "2022-08-10",
      caption: "パプアニューギニアの孤立した村で行われた、消滅危機言語を巡る30年のフィールドワークの記録。"
    },
    parameter: "[0.20, 0.85, 0.75, 0.20]",
    z_score: "[-0.60, 0.70, 0.50, -0.40]"
  },
  {
    isbn: "9784150315535",
    genre: "文学・小説",
    details: {
      title: "インランド・エクスペディション",
      author: "架空 太郎",
      release_date: "2024-01-15",
      caption: "地図にない内陸部へ向かった旅人たちが、記憶と静寂のなかに迷い込むアンビエントな長編小説。"
    },
    parameter: "[0.15, 0.95, 0.85, 0.10]",
    z_score: "[-0.70, 0.90, 0.70, -0.70]"
  },
  {
    isbn: "9784150314217",
    genre: "現代小説",
    details: {
      title: "アンバーの午後に",
      author: "佐藤 花子",
      release_date: "2023-06-25",
      caption: "琥珀色の光が差し込む古い喫茶店を舞台に、交錯する人間模様を描いたノスタルジックな群像劇。"
    },
    parameter: "[0.80, 0.25, 0.60, 0.35]",
    z_score: "[0.40, -0.30, 0.10, -0.10]"
  },
  {
    isbn: "9784150310035",
    genre: "ミステリー / SF",
    details: {
      title: "硝子のラビリンス",
      author: "北村 三郎",
      release_date: "2024-09-12",
      caption: "すべてが透明な素材で構築された都市で起きた、足跡の残らない失踪事件を追うハードボイルド。"
    },
    parameter: "[0.35, 0.65, 0.85, 0.30]",
    z_score: "[-0.20, 0.40, 0.70, -0.20]"
  },
  {
    isbn: "9784150310509",
    genre: "スチームパンク / 小説",
    details: {
      title: "鉄錆とオルゴール",
      author: "鈴木 次郎",
      release_date: "2023-03-30",
      caption: "かつて栄えた工業都市の廃墟で、朽ちかけた巨大なオルゴールの音色を聞き続ける少年の物語。"
    },
    parameter: "[0.30, 0.80, 0.50, 0.65]",
    z_score: "[-0.30, 0.70, -0.10, 0.40]"
  },
  {
    isbn: "9784150309688",
    genre: "ファンタジー",
    details: {
      title: "終着駅のアルカディア",
      author: "高橋 美咲",
      release_date: "2025-01-10",
      caption: "地図の果てにある終着駅から出発する夜行列車に乗り込んだ者たちが、それぞれの過去を精算する旅。"
    },
    parameter: "[0.75, 0.35, 0.70, 0.40]",
    z_score: "[0.30, -0.10, 0.30, 0.00]"
  },
  {
    isbn: "9784150308094",
    genre: "自然科学 / エッセイ",
    details: {
      title: "夜の鳥類学",
      author: "W. J. スミス",
      release_date: "2021-11-20",
      caption: "深夜の森に響く微かな鳴き声から、鳥たちの複雑なコミュニケーションと隠された生態を読み解く名著。"
    },
    parameter: "[0.25, 0.70, 0.90, 0.15]",
    z_score: "[-0.40, 0.50, 0.80, -0.50]"
  },
  {
    isbn: "9784150309695",
    genre: "詩集 / イラスト",
    details: {
      title: "深海魚のブランコ",
      author: "田中 健太",
      release_date: "2024-06-08",
      caption: "光の届かない海底で暮らす奇妙な生き物たちの孤独と、かすかな光への憧れを描いた短編詩集。"
    },
    parameter: "[0.10, 0.90, 0.95, 0.10]",
    z_score: "[-0.80, 0.80, 0.90, -0.70]"
  },
  {
    isbn: "9784150310332",
    genre: "ミステリー / 文学",
    details: {
      title: "霧のアーカイヴ",
      author: "中村 恵子",
      release_date: "2023-10-14",
      caption: "霧深い港町にある、失われた記憶や言葉だけを集めた図書館を巡る司書たちの静かな葛藤。"
    },
    parameter: "[0.40, 0.60, 0.80, 0.25]",
    z_score: "[-0.10, 0.30, 0.60, -0.30]"
  },
  {
    isbn: "9784150309886",
    genre: "歴史・SF",
    details: {
      title: "青銅のクロニクル",
      author: "小林 隼人",
      release_date: "2025-02-05",
      caption: "古代文明の遺跡から発掘された青銅のパーツを組み立てると、未来の予言が浮かび上がる壮大な歴史譚。"
    },
    parameter: "[0.45, 0.80, 0.40, 0.70]",
    z_score: "[0.00, 0.70, -0.30, 0.50]"
  }
]

books.each do |book_attrs|
  Book.create!(book_attrs)
end
puts "#{Book.count} books created."

puts "Seed finished successfully!"
