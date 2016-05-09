FactoryGirl.define do
  factory :user_follower do
    association :followed, factory: [:user]
    association :follower, factory: [:user]
  end
end
