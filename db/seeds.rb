# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

20.times do |c|
  sample_family_name = Gimei.last.kanji
  sample_given_name = Gimei.first.kanji
  sample_family_name_kana = Gimei.last.katakana
  sample_given_name_kana = Gimei.first.katakana
  sample_email = Faker::Internet.email
  sample_tel = Faker::Number.number(digits:11)
  sample_postal_code = Faker::Number.number(digits:7)
  sample_address = Faker::Address.street_address
  Customer.create!(
    family_name:      sample_family_name,
    given_name:       sample_given_name,
    family_name_kana: sample_family_name_kana,
    given_name_kana:  sample_given_name_kana,
    email:            sample_email,
    phone:            sample_tel,
    suspended:        false,
    postal_code:      sample_postal_code,
    address:          sample_address,
    password:         "samplepass4649",
    )
end

10.times do |n|
  Product.create!(
    name: "test#{n}",
    introduction: "this introduction created by test#{n}",
    genre_id: 1,
    price: n*100,
    image_id: "",
    sales_status: n%2 == 0 ? true : false
  )
end