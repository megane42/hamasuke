source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "rails", github: "rails/rails", branch: "main"
gem "sprockets-rails"
gem "mysql2"
gem "puma"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "bootstrap"
gem 'mini_racer'
gem "bootsnap", require: false
gem "sidekiq"

group :development do
  gem "annotate"
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
  gem "dotenv-rails"
end
