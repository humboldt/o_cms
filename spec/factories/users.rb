FactoryGirl.define do
  factory :user do
    email "user@example.com"
    password "password"
    trait :admin do
      after(:create) {|user| user.add_role(:admin)}
    end
  end
end
