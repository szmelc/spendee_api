# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.2', '>= 5.2.2.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'capistrano-rails', group: :development
gem 'coffee-rails', '~> 4.2'
gem 'grape'
gem 'grape-active_model_serializers', '~> 1.3.2'
gem 'grape-swagger'
gem 'grape-swagger-rails'
gem 'grape_on_rails_routes'
gem 'jbuilder', '~> 2.5'
gem 'jwt'
gem 'mini_magick', '~> 4.8'
gem 'rack-cors'
gem "therubyracer"
gem 'turbolinks', '~> 5'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 4.11'
  gem 'pry-rails'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
end

group :development do
  gem 'bullet'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
