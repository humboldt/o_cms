FactoryGirl.define do
  factory :category, class: 'OCms::Category' do
    name "Cycling Events Calendar"
    slug "cycling-events"
    icon "icon-bike"
    body "Sportives or road leisure. The first category are long and short massed-start road bike events while road leisure, as the name suggests, is more relaxed with the focus on enjoyment rather than times and you can use virtually any type of bike too."
  end
end
