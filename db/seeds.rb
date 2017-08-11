# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create(
    name: Faker::Name.name,
    email: "#{Faker::Internet.email.split("@").first}@#{ENV['EMAIL_WHITELIST']}",
    image: Faker::Avatar.image
  )
end

20.times do
  Compliment.create(
    complimenter: User.order("RANDOM()").first,
    complimentee: User.order("RANDOM()").first,
    text: Faker::Lorem.sentence
  )
end
