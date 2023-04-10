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

gem "sidekiq", "~> 6.5.0"
gem "sidekiq-throttled"
gem "redis-prescription", "~> 1.0.0"
gem "rails-i18n"
gem "ikedayama", git: "https://github.com/giftee/ikedayama-ruby.git"
gem "faraday"
gem "ransack"
gem "kaminari"
gem "bootstrap5-kaminari-views"

group :development do
  gem "annotate"
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
  gem "dotenv-rails"
end

group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
end
