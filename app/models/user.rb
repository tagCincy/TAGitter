class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :handle, presence: true, uniqueness: true

  has_one :profile
  has_many :user_followings, class_name: 'UserFollow', foreign_key: :follow_id
  has_many :follows, through: :user_followings
  has_many :user_followers, class_name: 'UserFollow', foreign_key: :follower_id
  has_many :followers, through: :user_followers
  has_many :posts

  delegate :name, :bio, :dob, :location, :protected, to: :profile

end
