class FavoritedPost < ApplicationRecord

  validates :user_id, uniqueness: { scope: :post_id }

  belongs_to :post, class_name: 'Post', foreign_key: 'post_id', counter_cache: :favorited_count
  belongs_to :user
end
