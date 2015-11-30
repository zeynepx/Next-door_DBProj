# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Example User",
             email: "example@nyu.edu",
             password:              "xiaolong1",
             password_confirmation: "xiaolong1",
             admin:true)

User.create!(name:  "Xiaolong Jiang",
             email: "xj370@nyu.edu",
             password:              "xiaolong1",
             password_confirmation: "xiaolong1",
             admin:true,
             id: 2)


99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@nyu.edu"
  password = "xiaolong1"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end


users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }