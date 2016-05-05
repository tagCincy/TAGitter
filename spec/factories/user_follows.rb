FactoryGirl.define do
  factory :user_follow do
    association :follow, factory: [:user]
    association :follower, factory: [:user]
  end
end
