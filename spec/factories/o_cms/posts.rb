FactoryGirl.define do
  factory :post, class: 'OCms::Post' do
    title "Post Title"
    slug "example-post-title"
    body "Post body content."
    excerpt "A description about the post."
    featured_image {Rack::Test::UploadedFile.new("#{FileUtils.pwd}/spec/fixtures/files/demo-image.jpg", 'image/jpeg', false)}
    meta_title "Post Title"
    meta_description "Post body content"
    meta_keywords "first, post, sample"
  end
end
