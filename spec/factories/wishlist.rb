# frozen_string_literal: true

FactoryBot.define do
  factory :wishlist do
    user
    title { Faker::Commerce.department }
    publicity { %w[hidden by_link listed].sample }
  end
end
