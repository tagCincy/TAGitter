FactoryGirl.define do
  factory :profile do
    name { FFaker::Name.name }
    bio { FFaker::HipsterIpsum.paragraph }
    location "Cincinnati, Ohio"
    dob { rand(13..35).years.ago.to_date }
    protected false

    trait :protected do
      protected true
    end

    factory :protected_profile, traits: [ :protected ]
  end
end
