# Temporary flag to see if any part is still using this Gemfile
p "=> Using root Gemfile"

# Use the Rails 5.0 gemfile as default and 4.2 in the Rails 4 dummy app
gemfile_version = Dir.pwd.include?("rails-4") ? 4.2 : 5.0
eval_gemfile File.join(File.dirname(__FILE__), "gemfiles/#{gemfile_version}.gemfile")
