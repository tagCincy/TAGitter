class FavoritedPost < ApplicationRecord
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id', counter_cache: :favorited_count
  belongs_to :user
end
