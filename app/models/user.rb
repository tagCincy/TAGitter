class User < ApplicationRecord

  devise :database_authenticatable, :recoverable, :trackable, :validatable, :registerable

  include DeviseTokenAuth::Concerns::User

  delegate :name, :bio, :dob, :location, :protected, :protected?, to: :profile

  validates :handle, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_]+\z/ }, length: { in: 3..15 }

  has_one :profile
  accepts_nested_attributes_for :profile

  has_many :user_followers, class_name: 'UserFollower', foreign_key: 'followed_id'
  has_many :followers, through: :user_followers

  has_many :users_followed, class_name: 'UserFollower', foreign_key: 'follower_id'
  has_many :followed, through: :users_followed

  has_many :posts

  has_many :favorited_posts, class_name: 'FavoritedPost'

  after_create :build_profile, unless: proc { |record| !!record.profile }

  scope :find_for_auth, -> (login) { where("provider='email' AND (lower(email)=:login OR lower(handle)=:login)", { login: login }) }

  def self.find_by_identifier(identifier)
    begin
      Integer(identifier)
    rescue ArgumentError, TypeError
      find_by_handle(identifier)
    else
      find(identifier)
    end
  end

  def to_param
    handle
  end

  private

  def build_profile
    self.create_profile(name: self.handle)
  end

end
