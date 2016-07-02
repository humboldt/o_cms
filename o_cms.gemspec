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
end
