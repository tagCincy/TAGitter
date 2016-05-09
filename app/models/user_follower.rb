class UserFollower < ApplicationRecord
  belongs_to :followed, class_name: 'User', counter_cache: :follower_count
  belongs_to :follower, class_name: 'User', counter_cache: :followed_count

  validates :follower_id, uniqueness: { scope: :followed_id }
end
