class UserFollow < ApplicationRecord
  belongs_to :follow, class_name: 'User', counter_cache: :follow_count
  belongs_to :follower, class_name: 'User', counter_cache: :follower_count

  validates :follow_id, uniqueness: { scope: :follower_id }
end
