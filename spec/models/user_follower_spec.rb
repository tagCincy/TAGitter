require 'rails_helper'

RSpec.describe UserFollower, type: :model do

  context 'attributes' do
    it { should respond_to :followed_id }
    it { should respond_to :follower_id }
  end

  context 'validations' do
    subject { build(:user_follower) }
    it { should validate_uniqueness_of(:follower_id).scoped_to(:followed_id) }
  end

  context 'associations' do
    it { should belong_to(:followed).class_name('User').counter_cache(:follower_count) }
    it { should belong_to(:follower).class_name('User').counter_cache(:followed_count) }
  end

  context 'scopes' do

  end

  context 'callbacks' do

  end

  context 'methods' do

  end
end
