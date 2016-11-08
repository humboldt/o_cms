FactoryGirl.define do
  factory :page, class: 'OCms::Page' do
    title "Epic Tours - Bicycling across America"
    slug "epic-tours"
    body "Bicycling across America is less about athleticism and more about spirit and perseverance, the capacity to roll with the bumps along the way. Having successfully done it says something about a person’s character; the accomplishment makes for a strong bullet point on a resume."
    excerpt "Someday, I’m going for it — the big one, the moon shot."
    featured_image ""
    meta_title "Epic Tours - Bicycling across America"
    meta_description "Someday, I’m going for it — the big one, the moon shot. Bicycling across America is less about athleticism and more about spirit and perseverance, the capacity to roll with the bumps along the way."
    meta_keywords "bicycling, moon shot, athletics, touring"
  end

  factory :about_page, class: 'OCms::Page' do
    title "What is adventure cycling and how can you get started?"
    slug "about-adventure-cycling-society"
    body "Our group is small but also mighty, we believe in the transforming national highways to be safer for all ages to travel by bike."
  end

  factory :subscribe_page, class: 'OCms::Page' do
    title "Subscribe to recent news and information about adventure cycling"
    slug "subscribe-today"
    body "Recieve up-to date infomation about our planned trips and how you can join us."
  end
end
