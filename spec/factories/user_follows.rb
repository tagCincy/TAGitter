FactoryGirl.define do
  factory :user_follow do
    association :follow, factory: [:confirmed_user]
    association :follower, factory: [:confirmed_user]
  end
end
