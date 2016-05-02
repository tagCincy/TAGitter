FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{FFaker::Lorem.word}.#{n}@tagitter.com" }
    sequence(:handle) { |n| "#{FFaker::Internet.user_name}#{n}" }
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

    factory :confirmed_user, traits: [:confirmed]
  end
end
