require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'attributes' do
    it { should respond_to :body }
    it { should respond_to :user_id }
    it { should respond_to :deleted }
    it { should respond_to :repost }
  end

  context 'validations' do

    subject { build(:post) }

    it 'requires body for original post' do
      should validate_presence_of(:body)
    end

    it 'does not require body if repost' do
      subject.body = nil
      subject.repost = build_stubbed(:post)
      should_not validate_presence_of(:body)
    end

    it 'should validate the uniquess of a report scoped to a user' do
      user = create(:user)
      repost =  build(:repost, user: user)
      expect(subject.valid?).to be_truthy

      repost.save

      another_repost = build(:post, repost_id: repost.repost_id, user: user)
      expect(another_repost.valid?).to be_falsey

      another_user_post = build(:post, user: user)
      expect(another_user_post.valid?).to be_truthy
    end

  end

  context 'associations' do
    it { should belong_to(:user).counter_cache(true) }
    it { should belong_to(:repost).class_name('Post').counter_cache(:reposted_count) }
    it { should have_many(:reposts).class_name('Post').with_foreign_key('repost_id') }
  end

  context 'scopes' do

  end

  context 'callbacks' do

  end

  context 'methods' do

    context '#repost?' do

      subject { build_stubbed(:post) }

      it 'should indicate the post is a repost' do
        expect(subject.is_repost?).to be_falsey
      end

      it 'should indicate the post is not a repost' do
        subject = build_stubbed(:repost)
        expect(subject.is_repost?).to be_truthy
      end

    end

  end
end
