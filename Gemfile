source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2.2'
gem 'jquery-rails'
gem 'uglifier'
gem 'new_google_recaptcha'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'dotenv-rails', :require => 'dotenv/rails-now'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug'
  gem 'sqlite3', '~> 1.3.13'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end
