require 'rails_helper'

RSpec.describe UserFollow, type: :model do

  context 'attributes' do
    it { should respond_to :follow_id }
    it { should respond_to :follower_id }
  end

  context 'validations' do
    subject { build(:user_follow) }
    it { should validate_uniqueness_of(:follow_id).scoped_to(:follower_id) }
  end

  context 'associations' do
    it { should belong_to(:follow).class_name('User').counter_cache(:follow_count) }
    it { should belong_to(:follower).class_name('User').counter_cache(:follower_count) }
  end

  context 'scopes' do

  end

  context 'callbacks' do

  end

  context 'methods' do

  end
end
