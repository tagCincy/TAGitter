class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  delegate :name, :bio, :dob, :location, :protected, :protected?, to: :profile

  validates :handle, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/}, length: { in: 3..15 }

  has_one :profile
  has_many :user_followings, class_name: 'UserFollow', foreign_key: :follow_id
  has_many :follows, through: :user_followings
  has_many :user_followers, class_name: 'UserFollow', foreign_key: :follower_id
  has_many :followers, through: :user_followers
  has_many :posts

  def self.find(id)
    begin
      Integer(id)
    rescue ArgumentError, TypeError
      find_by_handle(id)
    else
      super
    end
  end

  def to_param
    handle
  end

end
