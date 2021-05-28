# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'docopt'

group :test do
  gem 'rspec'
  gem 'simplecov', require: false
end

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false

  gem 'rubocop-rspec'
end

