class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :handle, :name, :bio, :location, :posts_count, :follow_count, :follower_count
end
