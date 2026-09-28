# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Admin.create!(
  email: "example@example.com",
  password: "password"
)

Customer.create!(
  last_name: "山田",
  first_name: "太郎",
  last_name_kana: "ヤマダ",
  first_name_kana: "タロウ",
  postal_code: "1234567",
  address: "東京都新宿区1-1-1",
  phone_number: "09012345678",
  email: "yamada@example.com",
  password: "password",
  is_active: true
)



Genre.create!(name: "ケーキ")
Genre.create!(name: "プリン")
Genre.create!(name: "焼き菓子")
Genre.create!(name: "キャンディ")

Item.create!(
  name: "ショートケーキ",
  description: "新鮮ないちごを使用したショートケーキです。",
  genre_id: "1",
  price: "600",
  is_active: true
  ).tap do |item|
  item.image.attach(
    io: File.open(Rails.root.join("db/images/ichigocake.jpg")),
    filename: "ichigocake.jpg"
  )
end

Item.create!(
  name: "チョコレートケーキ",
  description: "濃厚なチョコレートの味わいを楽しめる贅沢なチョコレートケーキです。",
  genre_id: "1",
  price: "700",
  is_active: true
  ).tap do |item|
  item.image.attach(
    io: File.open(Rails.root.join("db/images/chococake.jpg")),
    filename: "chococake.jpg"
  )
end

Item.create!(
  name: "チョコチップクッキー",
  description: "サクッとした食感のチョコチップクッキーです。",
  genre_id: "3",
  price: "400",
  is_active: true
  ).tap do |item|
  item.image.attach(
    io: File.open(Rails.root.join("db/images/Cookie.jpg")),
    filename: "Cookie.jpg"
  )
end

Item.create!(
  name: "マドレーヌ",
  description: "バターの豊かな香りがふわっと広がる優しい味わいのマドレーヌです。",
  genre_id: "3",
  price: "300",
  is_active: true
  ).tap do |item|
  item.image.attach(
    io: File.open(Rails.root.join("db/images/madeleine.jpg")),
    filename: "madeleine.jpg"
  )
end

Item.create!(
  name: "プリン",
  description: "卵のコクとミルクの優しい甘さを感じるなめらかな口どけのプリンです。",
  genre_id: "2",
  price: "500",
  is_active: true
  ).tap do |item|
  item.image.attach(
    io: File.open(Rails.root.join("db/images/pudding.jpg")),
    filename: "pudding.jpg"
  )
end

Item.create!(
  name: "いちごタルト",
  description: "サクッと香ばしいタルト生地になめらかなクリームと甘酸っぱいいちごをたっぷりのせた贅沢なタルトです。",
  genre_id: "1",
  price: "700",
  is_active: true
  ).tap do |item|
  item.image.attach(
    io: File.open(Rails.root.join("db/images/tart_ichigo.jpg")),
    filename: "tart_ichigo.jpg"
  )
end

Item.create!(
  name: "いちごドーナツ",
  description: "ふんわりドーナツに甘酸っぱいいちごのあじわいを感じられるドーナツです。",
  genre_id: "3",
  price: "300",
  is_active: true
  ).tap do |item|
  item.image.attach(
    io: File.open(Rails.root.join("db/images/donut_ichigo.jpg")),
    filename: "donut_ichigo.jpg"
  )
end

