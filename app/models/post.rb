class Post < ApplicationRecord

  validates_presence_of :body, unless: proc { |record| record.repost? }

  belongs_to :user, counter_cache: true
  belongs_to :repost, class_name: 'Post', optional: true, counter_cache: :reposted_count
  has_many :reposts, class_name: 'Post', foreign_key: :repost_id

  def repost?
    repost.present?
  end

end
