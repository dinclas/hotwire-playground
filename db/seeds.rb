# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users_progress = ProgressBar.new(50)
(1..50).each do |id|
  User.create!(
    id: id,
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    password: 'abc123',
    password_confirmation: 'abc123'
  )
  users_progress.increment!
end

posts_progress = ProgressBar.new(30)
(1..30).each do |id|
  is_reply = id == 1 ? false : [false, true, false].sample
  is_repost = is_reply || id == 1 ? false : [true, false].sample

  Post.create!(
    user_id: rand(1..50),
    repost: is_repost ? Post.find(rand(1...id)) : nil,
    text: is_repost ? nil : Faker::Quote.matz,
    posts_id: is_reply ? rand(1...id) : nil,
  )
  posts_progress.increment!
end


like_progress = ProgressBar.new(50*30)
(1..50).each do |user_id|
  (1..30).each do |post_id|
    Like.create!(
      user_id: user_id,
      post_id: post_id,
      liked: [false, true].sample
    )
    like_progress.increment!
  end
end