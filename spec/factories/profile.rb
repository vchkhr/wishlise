# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    user
    username { Faker::Internet.username(specifier: 6, separators: %w[_]) }
    display_name { Faker::Name.name }

    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test-avatar.png'), 'image/png') }
    end
  end
end
