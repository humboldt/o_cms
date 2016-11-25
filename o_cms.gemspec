$:.push File.expand_path("../lib", __FILE__)

require "o_cms/version"
require 'yaml'

Gem::Specification.new do |s|
  s.name        = "o_cms"
  s.version     = OCms::VERSION
  s.authors     = ["Benjamin Ayres"]
  s.email       = ["benjaminayres@hush.com"]
  s.homepage    = "https://github.com/benjaminayres/o_cms"
  s.summary     = "Outside CMS - Open source, easy to extend CMS for Rails"
  s.description = "Easily extend your application with Pages, Post and Image Library, customisable to suit any project."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  # backend
  s.add_dependency "rails", ">= 4.1.16"

  # frontend
  s.add_dependency "sass-rails"
  s.add_dependency "compass-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "rails-assets-tether", ">= 1.1.0"
  s.add_dependency "turbolinks"
  s.add_dependency "bootstrap", "4.0.0.alpha4"
  s.add_dependency "carrierwave", ">= 1.0.0.beta", "< 2.0"
  s.add_dependency "trix"
  s.add_dependency "mini_magick"

  # development dependencies
  s.add_development_dependency "better_errors"
  s.add_development_dependency "binding_of_caller"

  # test dependencies
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "email_spec"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "pry-doc"
  s.add_development_dependency "pry-inline"
  s.add_development_dependency "rb-readline"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "selenium-webdriver", "2.53.4"
  s.add_development_dependency "dotenv-rails"
  s.add_development_dependency "shoulda-matchers"

  # dummy app dependencies
  s.add_development_dependency "devise"
  s.add_development_dependency "cancancan"
  s.add_development_dependency "rolify"
  s.add_development_dependency "pg"
end
