FactoryGirl.define do
  factory :post do
    body { FFaker::HipsterIpsum.paragraph.truncate(rand(50..144), separator: /\s/, omission: '') }
    deleted false
    association :user, factory: [ :confirmed_user ]

    trait :reposted do
      body nil
      association :repost, factory: [:post]
    end

    factory :repost, traits: [ :reposted ]
  end
end
