$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "o_cms/version"
require 'yaml'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "o_cms"
  s.version     = OCms::VERSION
  s.authors     = ["Benjamin Ayres"]
  s.email       = ["ben@outsidehq.co.uk"]
  s.homepage    = "http://outsidehq.co.uk"
  s.summary     = "Simple and adaptable CMS."
  s.description = "Provide your application with content mangement features and a simple interface you can easily extend."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  # backend
  s.add_dependency 'rails', '>= 4.1.9'

  # frontend
  s.add_dependency 'sass-rails', '5.0'
  s.add_dependency 'compass-rails', '~> 2.0.0'
  s.add_dependency 'simple_form'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'rails-assets-tether', '>= 1.1.0'
  s.add_dependency 'turbolinks'
  s.add_dependency 'bootstrap', '~> 4.0.0.alpha3'
  s.add_dependency 'carrierwave', '>= 1.0.0.beta', '< 2.0'
  s.add_dependency 'trix'

  # development dependencies
  s.add_development_dependency 'better_errors'
  s.add_development_dependency 'binding_of_caller'
  s.add_development_dependency 'quiet_assets'

  # test dependencies
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'email_spec'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'pry-doc'
  s.add_development_dependency 'pry-inline'
  s.add_development_dependency 'rb-readline'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'dotenv-rails'
  s.add_development_dependency 'shoulda'

  # dummy app dependencies
  s.add_development_dependency 'devise'
  s.add_development_dependency 'cancancan'
  s.add_development_dependency 'rolify'
  s.add_development_dependency 'pg'
end
