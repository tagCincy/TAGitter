class Post < ApplicationRecord

  alias_attribute :post_time, :created_at

  delegate :protected?, to: :user

  validates_presence_of :body, unless: proc { |record| record.is_repost? }

  belongs_to :user, -> { includes(:profile) }, counter_cache: true
  belongs_to :repost, class_name: 'Post', optional: true, counter_cache: :reposted_count
  has_many :reposts, class_name: 'Post', foreign_key: :repost_id

  default_scope { includes(:user).active.order(created_at: :asc) }

  scope :active, -> { where(deleted: false) }
  scope :public_posts, -> { joins(user: [:profile]).where("profiles.protected" => false) }

  def is_repost?
    repost.present?
  end

end
