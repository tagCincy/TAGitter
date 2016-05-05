FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{FFaker::Lorem.word}.#{n}@tagitter.com" }
    sequence(:handle) { |n| "#{FFaker::Lorem.characters(rand(3..12))}#{n}" }
    password 'password'
    password_confirmation 'password'
    provider 'email'
    profile

    trait :protected do
      profile { create(:protected_profile) }
    end

    trait :attributed do
      profile_attributes { attributes_for(:profile) }
    end

    factory :protected_user, traits: [:protected]
    factory :user_attributes, traits: [:attributed]
  end
end
