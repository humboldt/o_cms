source "https://rubygems.org"

# Declare your gem's dependencies in o_cms.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

gem "rails", "~> 4.1.9"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
end

group :development, :test do
  gem 'pry-rails' 
  gem 'pry-doc' 
  gem 'pry-inline' 
  gem 'rb-readline' 
  gem 'capybara'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'dotenv-rails'
end

gem 'pg'
gem 'sass-rails', '5.0'
gem 'compass-rails', '~> 2.0.0'
gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'rails-assets-tether', '>= 1.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'simple_form'
gem 'carrierwave', '>= 1.0.0.beta', '< 2.0'

gem 'devise'
gem 'cancancan'
gem 'rolify'
