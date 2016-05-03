class PostSerializer < ActiveModel::Serializer

  attributes :id, :body, :post_time, :reposted_count, :favorited_count

  belongs_to :user
  belongs_to :repost

end
