# db/seeds.rb

Track.destroy_all
Novel.destroy_all

# Tracks (楽曲データ: 8件)
Track.create!([
  {
    title: "ネオン・ライム",
    artist: "City Beat",
    genre: "ポップ・ヒップホップ",
    release_date: "2023-06-15",
    preview_url: "https://example.com/audio/sample1.mp3",
    image_url: "https://example.com/images/track1.jpg",
    spotify_url: "https://open.spotify.com/track/sample1",
    applemusic_url: "https://music.apple.com/jp/album/sample1",
    itunes_id: "1000000001",
    valence: 0.82,
    energy: 0.75,
    acousticness: 0.15,
    weirdness: 0.20
  },
  {
    title: "Iron Vortex",
    artist: "Heavy Titans",
    genre: "ハードロック・メタル",
    release_date: "2021-09-20",
    preview_url: "https://example.com/audio/sample2.mp3",
    image_url: "https://example.com/images/track2.jpg",
    spotify_url: "https://open.spotify.com/track/sample2",
    applemusic_url: "https://music.apple.com/jp/album/sample2",
    itunes_id: "1000000002",
    valence: 0.35,
    energy: 0.95,
    acousticness: 0.00,
    weirdness: 0.30
  },
  {
    title: "変拍子の夕暮れ",
    artist: "Math & Echoes",
    genre: "エモ・マスロック・オルタナティブ",
    release_date: "2022-11-03",
    preview_url: "https://example.com/audio/sample3.mp3",
    image_url: "https://example.com/images/track3.jpg",
    spotify_url: "https://open.spotify.com/track/sample3",
    applemusic_url: "https://music.apple.com/jp/album/sample3",
    itunes_id: "1000000003",
    valence: 0.45,
    energy: 0.68,
    acousticness: 0.25,
    weirdness: 0.60
  },
  {
    title: "Cybernetic Pulse",
    artist: "Synth Lab",
    genre: "エレクトロニック",
    release_date: "2024-02-10",
    preview_url: "https://example.com/audio/sample4.mp3",
    image_url: "https://example.com/images/track4.jpg",
    spotify_url: "https://open.spotify.com/track/sample4",
    applemusic_url: "https://music.apple.com/jp/album/sample4",
    itunes_id: "1000000004",
    valence: 0.50,
    energy: 0.80,
    acousticness: 0.05,
    weirdness: 0.72
  },
  {
    title: "木漏れ日の木曜日",
    artist: "アコースティック・デュオ",
    genre: "アコースティック・フォーク",
    release_date: "2020-04-18",
    preview_url: "https://example.com/audio/sample5.mp3",
    image_url: "https://example.com/images/track5.jpg",
    spotify_url: "https://open.spotify.com/track/sample5",
    applemusic_url: "https://music.apple.com/jp/album/sample5",
    itunes_id: "1000000005",
    valence: 0.65,
    energy: 0.30,
    acousticness: 0.90,
    weirdness: 0.10
  },
  {
    title: "静寂の波紋",
    artist: "Silent Drone Project",
    genre: "アンビエント",
    release_date: "2019-08-12",
    preview_url: "https://example.com/audio/sample6.mp3",
    image_url: "https://example.com/images/track6.jpg",
    spotify_url: "https://open.spotify.com/track/sample6",
    applemusic_url: "https://music.apple.com/jp/album/sample6",
    itunes_id: "1000000006",
    valence: 0.20,
    energy: 0.10,
    acousticness: 0.85,
    weirdness: 0.75
  },
  {
    title: "電脳少女の憂鬱",
    artist: "Vocaloid Producer X",
    genre: "アニメ・ボカロ・インターネット",
    release_date: "2023-12-01",
    preview_url: "https://example.com/audio/sample7.mp3",
    image_url: "https://example.com/images/track7.jpg",
    spotify_url: "https://open.spotify.com/track/sample7",
    applemusic_url: "https://music.apple.com/jp/album/sample7",
    itunes_id: "1000000007",
    valence: 0.70,
    energy: 0.85,
    acousticness: 0.10,
    weirdness: 0.80
  },
  {
    title: "深夜2時のノクターン",
    artist: "Midnight Jazz Quartet",
    genre: "クラシック・ジャズ",
    release_date: "2021-03-25",
    preview_url: "https://example.com/audio/sample8.mp3",
    image_url: "https://example.com/images/track8.jpg",
    spotify_url: "https://open.spotify.com/track/sample8",
    applemusic_url: "https://music.apple.com/jp/album/sample8",
    itunes_id: "1000000008",
    valence: 0.30,
    energy: 0.25,
    acousticness: 0.92,
    weirdness: 0.25
  }
])

# Novels (小説データ: 8件)
Novel.create!([
  {
    title: "時計塔の密室",
    author: "謎解太郎",
    isbn: "9784000000001",
    genre: "ミステリー・サスペンス",
    caption: "吹雪の山荘で起きた不可解な殺人事件。提示されたアリバイの嘘を暴く。",
    release_date: "2021-02-18",
    image_url: "https://example.com/images/novel1.jpg",
    valence: 0.25,
    energy: 0.55,
    acousticness: 0.60,
    weirdness: 0.40
  },
  {
    title: "アンドロイドの見る夢",
    author: "未来健二",
    isbn: "9784000000002",
    genre: "SF",
    caption: "西暦2150年、人間とAIの境界線が消失した世界で探偵が追う真実。",
    release_date: "2023-11-30",
    image_url: "https://example.com/images/novel2.jpg",
    valence: 0.35,
    energy: 0.70,
    acousticness: 0.20,
    weirdness: 0.85
  },
  {
    title: "星屑のエルフェン",
    author: "幻影華",
    isbn: "9784000000003",
    genre: "ファンタジー",
    caption: "失われた魔法を取り戻すため、小さな精霊と少年が旅立つ冒険譚。",
    release_date: "2020-07-15",
    image_url: "https://example.com/images/novel3.jpg",
    valence: 0.60,
    energy: 0.65,
    acousticness: 0.40,
    weirdness: 0.50
  },
  {
    title: "放課後グラフィティ",
    author: "夏野爽",
    isbn: "9784000000004",
    genre: "青春・恋愛",
    caption: "屋上で交わした約束。甘酸っぱくも切ない高校生活最後の夏物語。",
    release_date: "2022-06-10",
    image_url: "https://example.com/images/novel4.jpg",
    valence: 0.85,
    energy: 0.72,
    acousticness: 0.30,
    weirdness: 0.08
  },
  {
    title: "川沿いの古い喫茶店",
    author: "海原しずく",
    isbn: "9784000000005",
    genre: "ヒューマンドラマ・文芸",
    caption: "人々が抱える悩みを静かに包み込む、一杯の珈琲と店主の温かな眼差し。",
    release_date: "2019-10-05",
    image_url: "https://example.com/images/novel5.jpg",
    valence: 0.45,
    energy: 0.20,
    acousticness: 0.95,
    weirdness: 0.12
  },
  {
    title: "闇に蠢く足音",
    author: "黒木迷宮",
    isbn: "9784000000006",
    genre: "ホラー・怪談",
    caption: "決して開けてはならない扉の向こうから聞こえる、呼ぶ声の正体。",
    release_date: "2022-08-01",
    image_url: "https://example.com/images/novel6.jpg",
    valence: 0.08,
    energy: 0.45,
    acousticness: 0.75,
    weirdness: 0.90
  },
  {
    title: "蒼穹の刃",
    author: "武道一馬",
    isbn: "9784000000007",
    genre: "歴史・時代小説",
    caption: "戦国時代、己の信条を貫き駆け抜けた若き武将の壮絶なる生涯。",
    release_date: "2018-05-20",
    image_url: "https://example.com/images/novel7.jpg",
    valence: 0.50,
    energy: 0.88,
    acousticness: 0.50,
    weirdness: 0.20
  },
  {
    title: "路地裏の観察記",
    author: "街歩き太郎",
    isbn: "9784000000008",
    genre: "ノンフィクション・エッセイ",
    caption: "10年間都市の片隅を歩き続けて見えた、人間模様と日常の愛おしさ。",
    release_date: "2023-01-12",
    image_url: "https://example.com/images/novel8.jpg",
    valence: 0.68,
    energy: 0.35,
    acousticness: 0.80,
    weirdness: 0.22
  }
])

puts "Seed data created successfully! (Tracks: #{Track.count}, Novels: #{Novel.count})"
