require 'capybara/rails'
require 'capybara/rspec'

Capybara.default_max_wait_time = 5

# Set Chrome as the local test browser
unless ENV['CI']
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  Capybara.javascript_driver = :chrome
  Capybara.default_max_wait_time = 10
end
