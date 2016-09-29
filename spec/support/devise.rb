# Pass devise Authentication in specs
# note: require 'devise' after require 'rspec/rails'
require 'devise'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
end
