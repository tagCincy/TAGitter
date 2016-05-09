class User::AuthenticatedUserPolicy < ApplicationPolicy

  def show?
    record.protected ? user.followed.include?(record) : true
  end

  def update?
    record.id.equal? user.id
  end

end