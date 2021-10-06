source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.12.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test, :demo do
  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker', '~> 2.7'
  # A gem providing "time travel", "time freezing", and "time acceleration"
  # capabilities, making it simple to test time-dependent code. It provides
  # a unified method to mock Time.now, Date.today, and DateTime.now in a single call.
  gem 'timecop', '~> 0.9.1'
  # Factory Girl Rails
  gem 'factory_bot_rails', '~> 5.1.0'
  # A Ruby gem to load environment variables from `.env`.
  gem 'dotenv-rails', '~> 2.7.0'
  # Seedbank gives your seed data a little structure.
  gem 'seedbank', '~> 0.5.0'
end


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # RSpec for Rails-3+
  gem 'rspec-rails', '~> 3.9.0'
  # help to kill N+1 queries and unused eager loading
  gem 'bullet', '~> 6.0.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Annotate Rails classes with schema and routes info
  gem 'annotate', '~> 3.0.0'
end

group :test do
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing.
  gem 'database_cleaner', '~> 1.6'
  # Collection of testing matchers extracted from Shoulda
  gem 'shoulda-matchers', '~> 4.1.0'
  # Brings back `assigns` and `assert_template` to your Rails tests
  gem 'rails-controller-testing', '~> 1.0.0'
  # Code style checking for RSpec files
  gem 'rubocop-rspec', '~> 1.37.0'
  # Automatically generate API documentation from RSpec
  gem 'rspec_api_documentation', '~> 6.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


## Background jobs
# Simple, efficient background processing for Ruby
gem 'sidekiq', '~> 6.2.1'

## State machines
# State machines for Ruby classes (plain Ruby, ActiveRecord, Mongoid)
gem 'aasm', '~> 5.0.0'

## API
# Simple, Fast, and Declarative Serialization Library for Ruby
gem 'blueprinter', '~> 0.20.0'
# Optimized JSON
gem 'oj'
# A set of Rails responders to dry up your application
gem 'responders', '~> 3.0.0'
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps
gem 'kaminari','~> 1.1.1'

## Auth
# Flexible authentication solution for Rails with Warden.
gem 'devise', '~> 4.7.1'
# Token based authentication for Rails JSON APIs. Designed to work with jToker and ng-token-auth.
gem 'devise_token_auth', '~> 1.1.3'

## Others
# An email validator for Rails
gem 'email_validator', '~> 2.0.1'
# Enumerated attributes with I18n and ActiveRecord/Mongoid support
gem 'enumerize', '~> 2.3.1'
gem 'paper_trail', '~> 10.3.0'

