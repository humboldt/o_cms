FactoryGirl.define do
  factory :image, class: 'OCms::Image' do
    name "Morning view"
    file {Rack::Test::UploadedFile.new("#{FileUtils.pwd}/spec/fixtures/files/mountains.jpg", 'image/jpeg', false)}
    description "My morning view of the German mountains."
  end

  factory :forest_image, class: 'OCms::Image' do
    name "Forest view"
    file {Rack::Test::UploadedFile.new("#{FileUtils.pwd}/spec/fixtures/files/forest.jpg", 'image/jpeg', false)}
    description "An long afternoon walk in the forest."
  end
end
