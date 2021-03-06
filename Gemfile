# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.6"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.6"
# Use pg as the database for Active Record
gem "pg"
# Use Puma as the app server
gem "puma", "~> 4.3"
# Use SCSS for stylesheets
gem "sassc-rails", "~> 2.1"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Sign up / sign in and user model
gem "devise"

# Manage JS modules
gem "webpacker"

# Form helpers
gem "simple_form"

# Countries of the world
gem "country_select"

# Thredded forum library
gem "thredded"

# Emoji library
gem "twemoji"

# ActiveJob library needed by thredded
gem "sucker_punch"

# ckeditor has a dependency on jquery
gem "jquery-rails"

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

# We don't use nokogiri directly, but it is a dependency of several other gems
# Listed here to force a specific update to a version with security fixes
gem "nokogiri", ">= 1.10.8"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", ">= 3.9.2"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"

  # Letter opener for when we don't have a proper mailer
  gem "letter_opener"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "database_cleaner"
  gem "selenium-webdriver"
  gem "simplecov", ">= 0.18.5"
end
