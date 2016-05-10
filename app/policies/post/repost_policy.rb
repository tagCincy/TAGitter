class Post::RepostPolicy < ApplicationPolicy

  def create?
    record.protected? ? record.user.followers.include?(user) : true
  end

end