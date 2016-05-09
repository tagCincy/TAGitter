class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :handle, :name, :bio, :location, :posts_count, :followed_count, :follower_count
end
