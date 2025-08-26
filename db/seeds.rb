# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.first

image_files = Dir.glob(Rails.root.join("public/images/*.{jpg,png}")).shuffle

10.times do |i|
  Bookmark.create!(
    title: Faker::Lorem.sentence(word_count: 2),
    url:   Faker::Internet.url,
    memo:  Faker::Lorem.sentence(word_count: 10),
    user_id: user.id,
    thumbnail_url: "/images/#{File.basename(image_files[i % image_files.size])}"
  )
end
