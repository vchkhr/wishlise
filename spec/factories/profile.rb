# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    user
    username { Faker::Internet.username(specifier: 6, separators: %w(_)) }
    display_name { Faker::Name.name }
  end
end
