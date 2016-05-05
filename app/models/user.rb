class User < ApplicationRecord

  devise :database_authenticatable, :recoverable, :trackable, :validatable, :registerable

  include DeviseTokenAuth::Concerns::User

  delegate :name, :bio, :dob, :location, :protected, :protected?, to: :profile

  validates :handle, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/}, length: { in: 3..15 }

  has_one :profile
  accepts_nested_attributes_for :profile

  has_many :user_followings, class_name: 'UserFollow', foreign_key: :follow_id
  has_many :follows, through: :user_followings

  has_many :user_followers, class_name: 'UserFollow', foreign_key: :follower_id
  has_many :followers, through: :user_followers

  has_many :posts

  after_create :build_profile, unless: proc { |record| !!record.profile }

  scope :find_for_auth, -> (login) { where(provider: 'email', email: login).or(where(provider: 'email', handle: login)) }

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

  private

  def build_profile
    self.create_profile(name: self.handle)
  end

end
