$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "o_cms/version"

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

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.15"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'better_errors' 
  s.add_development_dependency 'binding_of_caller'
  s.add_development_dependency 'quiet_assets'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'pry-doc'
  s.add_development_dependency 'pry-inline'
  s.add_development_dependency 'rb-readline'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'selenium-webdriver'

end
