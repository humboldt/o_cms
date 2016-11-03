FactoryGirl.define do
  factory :gallery, class: 'OCms::Gallery' do
    name "Adventure by bike in pictures"
    description "Pictures from one of my favorite cycling adventures."
  end

  factory :gallery_with_images, class: 'OCms::Gallery' do
    name "Trip Inspiration"
    description "Two pictures to get you inspired for yur next trip."

    after(:create) do |gallery, _evaluator|
      gallery.image_gallery.create(image: build(:image))
      gallery.image_gallery.create(image: build(:forest_image))
    end
  end
end
