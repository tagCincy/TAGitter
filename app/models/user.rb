class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :handle, presence: true, uniqueness: true
end
