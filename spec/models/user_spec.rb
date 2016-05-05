require 'rails_helper'

RSpec.describe User, type: :model do

  context 'attributes' do
    it { should respond_to :email }
    it { should respond_to :handle }
    it { should respond_to :password }
    it { should respond_to :posts_count }
    it { should respond_to :follow_count }
    it { should respond_to :follower_count }
    it { should respond_to :name }
    it { should respond_to :bio }
    it { should respond_to :location }
    it { should respond_to :dob }
    it { should respond_to :protected }
    it { should respond_to :protected? }

    context 'devise attributes' do
      it { should respond_to :reset_password_token }
      it { should respond_to :reset_password_sent_at }
      it { should respond_to :remember_created_at }
      it { should respond_to :sign_in_count }
      it { should respond_to :current_sign_in_at }
      it { should respond_to :last_sign_in_at }
      it { should respond_to :current_sign_in_ip }
      it { should respond_to :last_sign_in_ip }
    end
  end

  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:handle) }
    it { should validate_presence_of(:handle) }
    it { should validate_length_of(:handle).is_at_least(3).is_at_most(15) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end

  context 'associations' do
    it { should have_one(:profile) }
    it { should have_many(:user_followings).class_name('UserFollow').with_foreign_key(:follow_id) }
    it { should have_many(:follows).through(:user_followings) }
    it { should have_many(:user_followers).class_name('UserFollow').with_foreign_key(:follower_id) }
    it { should have_many(:followers).through(:user_followers) }
    it { should have_many(:posts) }
  end

  context 'scopes' do

  end

  context 'callbacks' do

  end

  context 'methods' do

    let!(:_user) { create(:user) }

    context '#class' do

      it "should find by handle or id" do
        expect(User.find(_user.handle)).to eql(_user)
        expect(User.find(_user.id)).to eql(_user)
      end

    end

    context '#instance' do

      it 'should return user handle as param' do
        expect(_user.to_param).to eql(_user.handle)
      end

    end

  end

end
