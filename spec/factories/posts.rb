FactoryGirl.define do
  factory :post do
    body { FFaker::HipsterIpsum.paragraph.truncate(rand(50..144), separator: /\s/, omission: '') }
    deleted false
    association :user, factory: [:user]
    created_at { rand(1..5000).minutes.ago }

    trait :reposted do
      body nil
      association :repost, factory: [:post]
    end

    trait :protected do
      association :user, factory: :protected_user
    end

    factory :repost, traits: [:reposted]
    factory :protected_post, traits: [:protected]
  end
end
