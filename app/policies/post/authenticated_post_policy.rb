class Post::AuthenticatedPostPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    if record.user.protected?
      record.user.followers.include?(user)
    else
      true
    end
  end

  def create?
    true
  end

  def update?
    record.user_id.eql? user.id
  end

  def destroy?
    record.user_id.eql? user.id
  end

end