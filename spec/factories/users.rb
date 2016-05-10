FactoryGirl.define do
  factory :user do

    ignore do
      first_name { FFaker::Name.first_name }
      last_name { FFaker::Name.last_name }
    end

    sequence(:email) { |n| "#{[first_name, last_name].join('.')}.#{n}@tagitter.com" }
    sequence(:handle) { |n| "#{first_name}#{n}" }
    password 'password'
    password_confirmation 'password'
    provider 'email'
    profile { create(:profile, name: [first_name, last_name].join(' ')) }

    trait :protected do
      profile { create(:protected_profile) }
    end

    trait :attributed do
      profile_attributes { attributes_for(:profile) }
    end

    trait :followed do
      association :follower, factory: [:user]
    end

    factory :protected_user, traits: [:protected]
    factory :user_attributes, traits: [:attributed]
    factory :followed_user, traits: [:followed]
  end
end
