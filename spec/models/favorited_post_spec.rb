require 'rails_helper'

RSpec.describe FavoritedPost, type: :model do
  context 'attributes' do
    it { should respond_to :user_id }
    it { should respond_to :post_id }
  end

  context 'validations' do

  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post).class_name('Post').with_foreign_key(:post_id).counter_cache(:favorited_count) }
  end

  context 'scopes' do

  end

  context 'callbacks' do

  end

  context 'methods' do

  end
end
