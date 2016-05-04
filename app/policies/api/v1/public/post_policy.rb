class Api::V1::Public::PostPolicy < ApplicationPolicy

  def initialize(record)
    @record = record
  end

  def show?
    !record.protected?
  end
end