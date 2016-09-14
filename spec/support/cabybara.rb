require 'capybara/rails'
require 'capybara/rspec' 

# Set Chrome as the default test browser
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
