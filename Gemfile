# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0', '>= 7.0.5'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.6'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Flexible authentication solution for Rails with Warden
gem 'devise', '~> 4.9.0'

# The most popular HTML, CSS, and JavaScript framework for developing responsive, mobile first projects on the web.
gem 'bootstrap', '~> 5.2.3'

# High-level wrapper for processing images for the web with ImageMagick or libvips.
gem 'image_processing', '~> 1.12', '>= 1.12.2'

# Common monads for Ruby
gem 'dry-monads', '~> 1.6'

# Validation library
gem 'dry-validation', '~> 1.10'

# dry-schema provides a DSL for defining schemas with keys and rules that should be applied to values
gem 'dry-schema', '~> 1.13', '>= 1.13.2'

# Nokogiri makes it easy and painless to work with XML and HTML from Ruby
gem 'nokogiri', '~> 1.15', '>= 1.15.3'

# A framework for building reusable, testable & encapsulated view components in Ruby on Rails.
gem 'view_component', '~> 3.3'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Shim to load environment variables from .env into ENV in development.
  gem 'dotenv-rails'

  # Byebug is a Ruby debugger.
  gem 'byebug', '~> 11.1', '>= 11.1.3'

  # rspec-rails is a testing framework for Rails 5+.
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # RuboCop is a Ruby code style checking and code formatting tool.
  gem 'rubocop', require: false

  # Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis.
  gem 'brakeman'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'

  # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer
  gem 'factory_bot_rails', '~> 6.2'

  # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
  gem 'faker', '~> 3.2'
end
