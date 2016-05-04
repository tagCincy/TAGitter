FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{FFaker::Lorem.word}.#{n}@tagitter.com" }
    sequence(:handle) { |n| "#{FFaker::Lorem.characters(rand(3..12))}#{n}" }
    password 'password'
    password_confirmation 'password'
    profile

    trait :confirmed do
      after(:build) do |user|
        user.confirmed_at = Date.today
        user.skip_confirmation!
      end

      after(:create) do |user|
        user.confirm
      end
    end

    trait :protected do
      profile { create(:protected_profile) }
    end

    factory :confirmed_user, traits: [:confirmed]
    factory :protected_user, traits: [:confirmed, :protected]
  end
end
