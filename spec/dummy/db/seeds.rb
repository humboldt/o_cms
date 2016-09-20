require 'random_data'

# Roles
[:admin, :company, :trainer].each do |role|
  Role.find_or_create_by({ name: role })
end
roles = Role.all

# Images
OCms::Image.create(:name => 'Image One', :file => 'img.png', :description => 'Nice Picture')

20.times do
  OCms::Image.create!(
    name:         RandomData.random_sentence,
    file:         RandomData.random_slug + '.jpg',
    description:  RandomData.random_paragraph
  )
end
images = OCms::Image.all

# Confirmation
puts "Seed finished"
puts "#{Role.count} roles created"
puts "#{OCms::Image.count} images created"
