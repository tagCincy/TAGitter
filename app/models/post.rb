class Post < ApplicationRecord

  alias_attribute :post_time, :created_at

  delegate :protected?, to: :user

  validates_presence_of :body, unless: proc { |record| record.is_repost? }

  belongs_to :user, -> { includes(:profile) }, counter_cache: true

  belongs_to :repost, class_name: 'Post', optional: true, counter_cache: :reposted_count
  has_many :reposts, class_name: 'Post', foreign_key: :repost_id

  has_many :favorited_posts, class_name: 'FavoritedPost'
  has_many :users_favorited, through: :favorited_posts, class_name: 'User', source: :user

  default_scope { includes(:user).active.order(created_at: :asc) }

  scope :active, -> { where(deleted: false) }
  scope :public_posts, -> { joins(user: [:profile]).where("profiles.protected" => false) }
  scope :user_feed, -> (user) { where(user: user.followed) }

  def destroy
    update(deleted: true)
  end

  def is_repost?
    repost.present?
  end

end
