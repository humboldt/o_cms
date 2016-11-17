require File.join(File.expand_path('../../../support/', '__FILE__'),'random_data.rb')

# Roles
[:admin, :company, :trainer].each do |role|
  Role.find_or_create_by({ name: role })
end
roles = Role.all

# Admin User
user = User.new(
  :email                 => "admin@outsidehq.co.uk",
  :password              => "password",
  :password_confirmation => "password"
)
user.save!
user.add_role :admin

# Images
file = Rack::Test::UploadedFile.new("./../../fixtures/files/mountains.jpg", 'image/jpeg', false)
OCms::Image.create(:name => 'Image One', :file => file, :description => 'Nice Picture')

20.times do
  OCms::Image.create!(
    name:         RandomData.random_sentence,
    file:         file,
    description:  RandomData.random_paragraph
  )
end
images = OCms::Image.all

# Posts
file = Rack::Test::UploadedFile.new("./../../fixtures/files/mountains.jpg", 'image/jpeg', false)

50.times do
  OCms::Post.create!(
    title:            RandomData.random_sentence,
    slug:             RandomData.random_slug,
    body:             RandomData.random_paragraph,
    excerpt:          RandomData.random_paragraph,
    featured_image:   RandomData.random_slug + '.jpg',
    meta_title:       RandomData.random_sentence,
    meta_description: RandomData.random_paragraph,
    meta_keywords:    RandomData.random_word + ', ' + RandomData.random_word
  )
end

# Categories
15.times do
  OCms::Category.create!(
    name:             RandomData.random_sentence,
    slug:             RandomData.random_slug,
    icon:             RandomData.random_slug,
    body:             RandomData.random_paragraph,
    meta_title:       RandomData.random_sentence,
    meta_description: RandomData.random_paragraph,
    meta_keywords:    RandomData.random_word + ', ' + RandomData.random_word
  )
end

# Pages
file = Rack::Test::UploadedFile.new("./../../fixtures/files/mountains.jpg", 'image/jpeg', false)

50.times do
  OCms::Page.create!(
    title:            RandomData.random_sentence,
    slug:             RandomData.random_slug,
    body:             RandomData.random_paragraph,
    excerpt:          RandomData.random_paragraph,
    featured_image:   RandomData.random_slug + '.jpg',
    meta_title:       RandomData.random_sentence,
    meta_description: RandomData.random_paragraph,
    meta_keywords:    RandomData.random_word + ',' + RandomData.random_word
  )
end

# Galleries
10.times do
  OCms::Gallery.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
galleries = OCms::Gallery.all

# Confirmation
puts "Seed finished"
puts "#{Role.count} roles created"
puts "#{User.count} users created"
puts "#{OCms::Image.count} images created"
puts "#{OCms::Post.count} posts created"
puts "#{OCms::Category.count} categories created"
puts "#{OCms::Page.count} pages created"
puts "#{OCms::Gallery.count} galleries created"
