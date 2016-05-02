FactoryGirl.define do
  factory :favorited_post do
    association :post, factory: [ :post ]
    association :user, factory: [ :confirmed_user ]
  end
end
