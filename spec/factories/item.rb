# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    wishlist
    url { Faker::Internet.url }
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph_by_chars }
    price { Faker::Commerce.price }
  end
end
