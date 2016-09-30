require 'capybara/rails'
require 'capybara/rspec'

# Set Chrome as the local test browser
unless ENV['CI']
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  Capybara.javascript_driver = :chrome
end
