FactoryGirl.define do
  factory :image, class: 'OCms::Image' do
    name "Morning view"
    file {Rack::Test::UploadedFile.new("#{FileUtils.pwd}/spec/fixtures/files/demo-image.jpg", 'image/jpeg', false)}
    description "My morning view of the German mountains."
  end

  # => TODO: Name this properly, image_two feels vague
  factory :image_two, class: 'OCms::Image' do
    name "Forest view"
    file {Rack::Test::UploadedFile.new("#{FileUtils.pwd}/spec/fixtures/files/demo-image.jpg", 'image/jpeg', false)}
    description "A long walk in the forst."
  end
end
