class User::PublicUserPolicy < ApplicationPolicy
  def initialize(record)
    @record = record
  end

  def show?
    !record.protected?
  end
end