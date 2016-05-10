class Post::FavoritedPolicy < ApplicationPolicy

  def create?
    if record.user.protected?
      record.user.followers.include?(user)
    else
      true
    end
  end

  def destroy?
    true
  end

end