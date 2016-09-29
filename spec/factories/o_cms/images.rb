FactoryGirl.define do
  factory :image, class: 'OCms::Image' do
    name "Morning view"
    file {Rack::Test::UploadedFile.new("#{FileUtils.pwd}/spec/fixtures/files/demo-image.jpg", 'image/jpeg', false)}
    description "My morning view of the German mountains."
  end
end
