RSpec.configure do |config|
  # Use the Rails 4 factories folder path unless testing Rails 5
  factories_folder_path = ENV['OCMS_RAILS_VERSION_MAJOR'] == '4' ? "../../factories" : "../../../factories"

  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.definition_file_paths = [File.expand_path(factories_folder_path, __FILE__)]
    FactoryGirl.find_definitions
  end
end
