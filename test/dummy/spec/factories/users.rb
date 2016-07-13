FactoryGirl.define do
  factory :user do
    email "user@example.com"
    password "password"
    trait :admin do
      after(:create) {|user| user.add_role(:admin)}
    end
    trait :company do
      after(:create) {|user| user.add_role(:company)}
    end
    trait :trainer do
      after(:create) {|user| user.add_role(:trainer)}
    end
  end
end
