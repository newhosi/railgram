# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(name:                  "example-user",
             email:                 "example-user@example.com",
             password:              "password",
             password_confirmation: "password",
             admin:                 true,
             activated:             true,
             activated_at:          Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  user = User.create!(
    name:                  name,
    email:                 email,
    password:              password,
    password_confirmation: password,
    activated:             true,
    activated_at:          Time.zone.now)
  3.times do |n|
    user.microposts.create!(
      content: Faker::Lorem.sentence(word_count: 5)
    )
  end
end
