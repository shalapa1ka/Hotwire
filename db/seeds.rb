# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

=begin
5.times do
  Image.create(
    title: FFaker::Lorem.word,
    url: FFaker::Image.url
  )
end
=end

=begin
5.times do
  Folder.create(
    title: FFaker::Lorem.word,
    description: FFaker::Lorem.sentence
  )
end
=end

=begin
10.times do
  Bookmark.create(
    title: FFaker::Lorem.word,
    folder_id: rand(1..5)
  )
end
=end

User.create name: 'fake'
