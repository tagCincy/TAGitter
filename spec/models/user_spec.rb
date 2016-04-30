require 'rails_helper'

RSpec.describe User, type: :model do

  context 'attributes' do
    it { should respond_to :email }
    it { should respond_to :handle }
    it { should respond_to :password }

    context 'devise attributes' do
      it { should respond_to :reset_password_token }
      it { should respond_to :reset_password_sent_at }
      it { should respond_to :remember_created_at }
      it { should respond_to :sign_in_count }
      it { should respond_to :current_sign_in_at }
      it { should respond_to :last_sign_in_at }
      it { should respond_to :current_sign_in_ip }
      it { should respond_to :last_sign_in_ip }
      it { should respond_to :confirmation_token }
      it { should respond_to :confirmed_at }
      it { should respond_to :confirmation_sent_at }
      it { should respond_to :unconfirmed_email  }
    end
  end

  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:handle) }
    it { should validate_presence_of(:handle) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end

  context 'associations' do

  end

  context 'scopes' do

  end

  context 'callbacks' do

  end

  context 'methods' do

  end

end
