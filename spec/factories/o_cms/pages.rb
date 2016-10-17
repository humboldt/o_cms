FactoryGirl.define do
  factory :page, class: 'OCms::Page' do
    title "Page Title"
    slug "example-page-title"
    body "Page body content."
    excerpt "A description about the page."
    featured_image {Rack::Test::UploadedFile.new("#{FileUtils.pwd}/spec/fixtures/files/demo-image.jpg", 'image/jpeg', false)}
    meta_title "Page Title"
    meta_description "Page body content"
    meta_keywords "first, page, sample"
  end
end
