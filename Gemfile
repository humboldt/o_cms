# Use the Rails 4.2 gemfile as default and 5.0 in the Rails 5 dummy app
gemfile_version = Dir.pwd.include?("rails-5") ? 5.0 : 4.2
eval_gemfile File.join(File.dirname(__FILE__), "gemfiles/#{gemfile_version}.gemfile")
