class User::FollowPolicy < ApplicationPolicy

  def create?
    if record.protected?
      record.followed.include?(user)
    else
      true
    end
  end

  def destroy?
    true
  end

end