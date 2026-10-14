# db/seeds.rb

puts "Cleaning database..."
Track.destroy_all
Book.destroy_all

puts "Creating tracks (10 items)..."
tracks = [
  {
    title: "Amber Avenue",
    artist: "The Pale Lanterns",
    itunes_id: "tr_1001",
    genre: "Indie Rock",
    release_date: Date.new(2024, 5, 12),
    image_url: "https://example.com/images/amber_avenue.jpg",
    preview_url: "https://example.com/previews/amber_avenue.m4a",
    spotify_url: "https://open.spotify.com/track/sample1",
    applemusic_url: "https://music.apple.com/us/album/sample1",
    details: { tempo: "120", mood: "melancholic", instruments: ["guitar", "synthesizer"] },
    parameter: "[0.85, 0.20, 0.65, 0.40]"
  },
  {
    title: "Cave Salamander",
    artist: "Subterranean Echoes",
    itunes_id: "tr_1002",
    genre: "Ambient / Drone",
    release_date: Date.new(2023, 11, 4),
    image_url: "https://example.com/images/cave_salamander.jpg",
    preview_url: "https://example.com/previews/cave_salamander.m4a",
    spotify_url: "https://open.spotify.com/track/sample2",
    applemusic_url: "https://music.apple.com/us/album/sample2",
    details: { tempo: "65", mood: "dark", instruments: ["drone synth", "field recording"] },
    parameter: "[0.10, 0.90, 0.80, 0.15]"
  },
  {
    title: "Guernica's Rain",
    artist: "Monochrome Canvas",
    itunes_id: "tr_1003",
    genre: "Post-Rock",
    release_date: Date.new(2025, 2, 20),
    image_url: "https://example.com/images/guernicas_rain.jpg",
    preview_url: "https://example.com/previews/guernicas_rain.m4a",
    spotify_url: "https://open.spotify.com/track/sample3",
    applemusic_url: "https://music.apple.com/us/album/sample3",
    details: { tempo: "140", mood: "intense", instruments: ["distorted guitar", "strings"] },
    parameter: "[0.40, 0.75, 0.30, 0.85]"
  },
  {
    title: "Monochrome Glass",
    artist: "Vitreous Cycle",
    itunes_id: "tr_1004",
    genre: "Minimalist",
    release_date: Date.new(2023, 8, 15),
    image_url: "https://example.com/images/monochrome_glass.jpg",
    preview_url: "https://example.com/previews/monochrome_glass.m4a",
    spotify_url: "https://open.spotify.com/track/sample4",
    applemusic_url: "https://music.apple.com/us/album/sample4",
    details: { tempo: "80", mood: "cold", instruments: ["piano", "ambient pads"] },
    parameter: "[0.30, 0.60, 0.90, 0.20]"
  },
  {
    title: "Neon Nocturne",
    artist: "Midnight Transit",
    itunes_id: "tr_1005",
    genre: "Synthwave",
    release_date: Date.new(2024, 10, 30),
    image_url: "https://example.com/images/neon_nocturne.jpg",
    preview_url: "https://example.com/previews/neon_nocturne.m4a",
    spotify_url: "https://open.spotify.com/track/sample5",
    applemusic_url: "https://music.apple.com/us/album/sample5",
    details: { tempo: "115", mood: "nostalgic", instruments: ["analog synth", "drum machine"] },
    parameter: "[0.70, 0.40, 0.50, 0.60]"
  },
  {
    title: "Paper Lanterns",
    artist: "The Paper Kites",
    itunes_id: "tr_1006",
    genre: "Folk",
    release_date: Date.new(2022, 4, 18),
    image_url: "https://example.com/images/paper_lanterns.jpg",
    preview_url: "https://example.com/previews/paper_lanterns.m4a",
    spotify_url: "https://open.spotify.com/track/sample6",
    applemusic_url: "https://music.apple.com/us/album/sample6",
    details: { tempo: "95", mood: "warm", instruments: ["acoustic guitar", "cello"] },
    parameter: "[0.80, 0.15, 0.70, 0.25]"
  },
  {
    title: "Subterranean Drift",
    artist: "Deep Resonance",
    itunes_id: "tr_1007",
    genre: "Ambient",
    release_date: Date.new(2024, 1, 10),
    image_url: "https://example.com/images/subterranean_drift.jpg",
    preview_url: "https://example.com/previews/subterranean_drift.m4a",
    spotify_url: "https://open.spotify.com/track/sample7",
    applemusic_url: "https://music.apple.com/us/album/sample7",
    details: { tempo: "50", mood: "hypnotic", instruments: ["sub bass", "sine wave"] },
    parameter: "[0.05, 0.95, 0.95, 0.05]"
  },
  {
    title: "Rust & Velvet",
    artist: "Velvet Industrial",
    itunes_id: "tr_1008",
    genre: "Industrial",
    release_date: Date.new(2023, 9, 5),
    image_url: "https://example.com/images/rust_velvet.jpg",
    preview_url: "https://example.com/previews/rust_velvet.m4a",
    spotify_url: "https://open.spotify.com/track/sample8",
    applemusic_url: "https://music.apple.com/us/album/sample8",
    details: { tempo: "130", mood: "heavy", instruments: ["metallic percussion", "bass guitar"] },
    parameter: "[0.35, 0.85, 0.40, 0.80]"
  },
  {
    title: "Forgotten Frequencies",
    artist: "Static Memory",
    itunes_id: "tr_1009",
    genre: "Lo-Fi / Chillhop",
    release_date: Date.new(2024, 7, 22),
    image_url: "https://example.com/images/forgotten_frequencies.jpg",
    preview_url: "https://example.com/previews/forgotten_frequencies.m4a",
    spotify_url: "https://open.spotify.com/track/sample9",
    applemusic_url: "https://music.apple.com/us/album/sample9",
    details: { tempo: "85", mood: "dusty", instruments: ["vinyl noise", "rhodes piano"] },
    parameter: "[0.60, 0.30, 0.75, 0.30]"
  },
  {
    title: "Silent Archipelago",
    artist: "Isle of Silence",
    itunes_id: "tr_1010",
    genre: "New Age",
    release_date: Date.new(2025, 3, 1),
    image_url: "https://example.com/images/silent_archipelago.jpg",
    preview_url: "https://example.com/previews/silent_archipelago.m4a",
    spotify_url: "https://open.spotify.com/track/sample10",
    applemusic_url: "https://music.apple.com/us/album/sample10",
    details: { tempo: "70", mood: "serene", harp: ["harp", "flute"] },
    parameter: "[0.50, 0.10, 0.95, 0.10]"
  }
]

tracks.each do |track_attrs|
  Track.create!(track_attrs)
end
puts "#{Track.count} tracks created."

puts "Creating books (10 items)..."
books = [
  {
    title: "最期の言葉の村へ：消滅危機言語タヤップを話す人々との30年",
    author: "ドン・クリック",
    isbn: "9784000000001",
    genre: "ノンフィクション / 人類学",
    caption: "パプアニューギニアの孤立した村で行われた、消滅危機言語を巡る30年のフィールドワークの記録。",
    release_date: Date.new(2022, 8, 10),
    image_url: "https://example.com/images/taiyap.jpg",
    details: { setting: "Papua New Guinea", tone: "scholarly and reflective", themes: ["language loss", "anthropology"] },
    parameter: "[0.20, 0.85, 0.75, 0.20]"
  },
  {
    title: "インランド・エクスペディション",
    author: "架空 太郎",
    isbn: "9784000000002",
    genre: "文学・小説",
    caption: "地図にない内陸部へ向かった旅人たちが、記憶と静寂のなかに迷い込むアンビエントな長編小説。",
    release_date: Date.new(2024, 1, 15),
    image_url: "https://example.com/images/inland.jpg",
    details: { setting: "Unknown Inland", tone: "surreal and quiet", themes: ["isolation", "memory"] },
    parameter: "[0.15, 0.95, 0.85, 0.10]"
  },
  {
    title: "アンバーの午後に",
    author: "佐藤 花子",
    isbn: "9784000000003",
    genre: "現代小説",
    caption: "琥珀色の光が差し込む古い喫茶店を舞台に、交錯する人間模様を描いたノスタルジックな群像劇。",
    release_date: Date.new(2023, 6, 25),
    image_url: "https://example.com/images/amber_afternoon.jpg",
    details: { setting: "Coffee shop", tone: "warm and melancholic", themes: ["nostalgia", "daily life"] },
    parameter: "[0.80, 0.25, 0.60, 0.35]"
  },
  {
    title: "硝子のラビリンス",
    author: "北村 三郎",
    isbn: "9784000000004",
    genre: "ミステリー / SF",
    caption: "すべてが透明な素材で構築された都市で起きた、足跡の残らない失踪事件を追うハードボイルド。",
    release_date: Date.new(2024, 9, 12),
    image_url: "https://example.com/images/glass_labyrinth.jpg",
    details: { setting: "Glass City", tone: "cold and precise", themes: ["illusion", "mystery"] },
    parameter: "[0.35, 0.65, 0.85, 0.30]"
  },
  {
    title: "鉄錆とオルゴール",
    author: "鈴木 次郎",
    isbn: "9784000000005",
    genre: "スチームパンク / 小説",
    caption: "かつて栄えた工業都市の廃墟で、朽ちかけた巨大なオルゴールの音色を聞き続ける少年の物語。",
    release_date: Date.new(2023, 3, 30),
    image_url: "https://example.com/images/rust_musicbox.jpg",
    details: { setting: "Industrial Ruin", tone: "industrial and melancholic", themes: ["decay", "youth"] },
    parameter: "[0.30, 0.80, 0.50, 0.65]"
  },
  {
    title: "終着駅のアルカディア",
    author: "高橋 美咲",
    isbn: "9784000000006",
    genre: "ファンタジー",
    caption: "地図の果てにある終着駅から出発する夜行列車に乗り込んだ者たちが、それぞれの過去を精算する旅。",
    release_date: Date.new(2025, 1, 10),
    image_url: "https://example.com/images/terminal_arcadia.jpg",
    details: { setting: "Night Train", tone: "dreamlike and warm", themes: ["journey", "redemption"] },
    parameter: "[0.75, 0.35, 0.70, 0.40]"
  },
  {
    title: "夜の鳥類学",
    author: "W. J. スミス",
    isbn: "9784000000007",
    genre: "自然科学 / エッセイ",
    caption: "深夜の森に響く微かな鳴き声から、鳥たちの複雑なコミュニケーションと隠された生態を読み解く名著。",
    release_date: Date.new(2021, 11, 20),
    image_url: "https://example.com/images/night_ornithology.jpg",
    details: { setting: "Night Forest", tone: "observative and calm", themes: ["nature", "sound"] },
    parameter: "[0.25, 0.70, 0.90, 0.15]"
  },
  {
    title: "深海魚のブランコ",
    author: "田中 健太",
    isbn: "9784000000008",
    genre: "詩集 / イラスト",
    caption: "光の届かない海底で暮らす奇妙な生き物たちの孤独と、かすかな光への憧れを描いた短編詩集。",
    release_date: Date.new(2024, 6, 8),
    image_url: "https://example.com/images/deep_sea_swing.jpg",
    details: { setting: "Deep Sea", tone: "surreal and quiet", themes: ["isolation", "poetic"] },
    parameter: "[0.10, 0.90, 0.95, 0.10]"
  },
  {
    title: "霧のアーカイヴ",
    author: "中村 恵子",
    isbn: "9784000000009",
    genre: "ミステリー / 文学",
    caption: "霧深い港町にある、失われた記憶や言葉だけを集めた図書館を巡る司書たちの静かな葛藤。",
    release_date: Date.new(2023, 10, 14),
    image_url: "https://example.com/images/foggy_archive.jpg",
    details: { setting: "Foggy Port Town", tone: "mysterious and calm", themes: ["archive", "memory"] },
    parameter: "[0.40, 0.60, 0.80, 0.25]"
  },
  {
    title: "青銅のクロニクル",
    author: "小林 隼人",
    isbn: "9784000000010",
    genre: "歴史・SF",
    caption: "古代文明の遺跡から発掘された青銅のパーツを組み立てると、未来の予言が浮かび上がる壮大な歴史譚。",
    release_date: Date.new(2025, 2, 5),
    image_url: "https://example.com/images/bronze_chronicle.jpg",
    details: { setting: "Ancient Ruin", tone: "epic and heavy", themes: ["history", "future"] },
    parameter: "[0.45, 0.80, 0.40, 0.70]"
  }
]

books.each do |book_attrs|
  Book.create!(book_attrs)
end
puts "#{Book.count} books created."

puts "Seed finished successfully!"