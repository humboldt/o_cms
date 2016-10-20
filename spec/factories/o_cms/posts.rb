FactoryGirl.define do
  factory :post, class: 'OCms::Post' do
    title "Packing Up for your Adventure Cycling Trip"
    slug "packing-up"
    body "You've spent months dreaming and planning your bike journey. You've poured over maps and shopped for gear. You've trained ... well, hopefully you have. There is a frantic joy/dread to those final hours before you set out on a journey. Life never seems so hectic as those last couple of days before a big bike trip. What did you forget? Is that bike box overweight? Are you bringing too much stuff?"
    excerpt "Life never seems so hectic as those last couple of days before a big bike trip. What did you forget?"
    featured_image {Rack::Test::UploadedFile.new("#{FileUtils.pwd}/spec/fixtures/files/demo-image.jpg", 'image/jpeg', false)}
    meta_title "Packing Up for your Adventure Cycling Trip"
    meta_description "You've spent months dreaming and planning your bike journey. You've poured over maps and shopped for gear. There is a frantic joy/dread to those final hours before you set out on a journey."
    meta_keywords "cycling, adventure, pack list, planning"
  end
end
